#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPT_PATH=`pwd -P`
popd > /dev/null
SCRIPT_FILE=`basename $0`

COLOR_INFO='\033[0;36m'
COLOR_NONE='\033[0m'

source ${SCRIPT_PATH}/lib/query_problem.sh


function usage() {
    echo -e "Usage: ${0} [file]"
    echo -e ""
    echo -e "Example:"
    echo -e ""
    echo -e "   ${0} ./LargestNumber.cpp"
    echo -e ""
}

if [ $# -lt 1 ] || [[ ! -f ${1} ]]; then
    usage
    exit 255
fi

DIR=`cd $(dirname ${1}) && pwd -P`
FILE=${DIR}/$(basename ${1})

URL=`grep Source ${FILE} | awk '{print $4}'`

URL=$(echo $URL | sed -e 's/oj\.leetcode\.com/leetcode\.com/g')

get_question_slug ${URL}
query_problem ${URL} ${QUESTION_TITLE_SLUG}

FILE=`echo ${FILE} | sed "s/.*\/algorithms/\.\/algorithms/"`

echo "|${QUESTION_FRONTEND_ID}|[${QUESTION_TITLE}](${URL}) | [Java](${2})|${QUESTION_DIFFICULTY}|"
