#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* longestCommonSuffix(char** str1, int str1Size, char** str2, int str2Size, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int idx1 = queries[i][0];
        int idx2 = queries[i][1];

        char* s1 = str1[idx1];
        char* s2 = str2[idx2];

        int len1 = strlen(s1);
        int len2 = strlen(s2);

        int commonSuffixLength = 0;
        int j = len1 - 1;
        int k = len2 - 1;

        while (j >= 0 && k >= 0 && s1[j] == s2[k]) {
            commonSuffixLength++;
            j--;
            k--;
        }

        result[i] = commonSuffixLength;
    }

    return result;
}