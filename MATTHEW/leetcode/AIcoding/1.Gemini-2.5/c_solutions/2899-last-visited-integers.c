#include <stdlib.h>
#include <string.h>
#include <stdio.h> // For atoi, though it's in stdlib.h

int* lastVisitedIntegers(char** words, int wordsSize, int* returnSize) {
    int* visitedNums = NULL;
    int visitedNumsSize = 0;
    int visitedNumsCapacity = 0;

    int* results = NULL;
    int resultsSize = 0;
    int resultsCapacity = 0;

    int prevCount = 0;

    for (int i = 0; i < wordsSize; i++) {
        if (strcmp(words[i], "prev") == 0) {
            prevCount++;
            int result;
            if (prevCount <= visitedNumsSize) {
                result = visitedNums[visitedNumsSize - prevCount];
            } else {
                result = -1;
            }

            if (resultsSize == resultsCapacity) {
                resultsCapacity = (resultsCapacity == 0) ? 10 : resultsCapacity * 2;
                results = (int*)realloc(results, resultsCapacity * sizeof(int));
            }
            results[resultsSize++] = result;
        } else {
            prevCount = 0;
            int num = atoi(words[i]);

            if (visitedNumsSize == visitedNumsCapacity) {
                visitedNumsCapacity = (visitedNumsCapacity == 0) ? 10 : visitedNumsCapacity * 2;
                visitedNums = (int*)realloc(visitedNums, visitedNumsCapacity * sizeof(int));
            }
            visitedNums[visitedNumsSize++] = num;
        }
    }

    free(visitedNums);
    *returnSize = resultsSize;
    return results;
}