#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **camelMatch(char **queries, int queriesSize, char *pattern, int *returnSize) {
    char **result = (char **)malloc(queriesSize * sizeof(char *));
    *returnSize = 0;
    int patternLen = strlen(pattern);

    for (int i = 0; i < queriesSize; i++) {
        char *query = queries[i];
        int qLen = strlen(query);
        int pIdx = 0;
        int match = 1;

        for (int j = 0; j < qLen; j++) {
            if (pIdx < patternLen && query[j] == pattern[pIdx]) {
                pIdx++;
            } else if (isupper(query[j])) {
                match = 0;
                break;
            }
        }

        if (pIdx == patternLen && match) {
            result[*returnSize] = "true";
            (*returnSize)++;
        } else {
            result[*returnSize] = "false";
            (*returnSize)++;
        }
    }

    return result;
}