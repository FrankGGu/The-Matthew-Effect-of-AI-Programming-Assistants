#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int index;
    char* str;
} Pair;

int compare(const void* a, const void* b) {
    Pair* pairA = (Pair*)a;
    Pair* pairB = (Pair*)b;
    return strcmp(pairA->str, pairB->str);
}

int* smallestTrimmedNumbers(char** nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int k = queries[i][0];
        int trim = queries[i][1];

        Pair* trimmedNums = (Pair*)malloc(sizeof(Pair) * numsSize);
        for (int j = 0; j < numsSize; j++) {
            int len = strlen(nums[j]);
            trimmedNums[j].index = j;
            trimmedNums[j].str = nums[j] + (len - trim);
        }

        qsort(trimmedNums, numsSize, sizeof(Pair), compare);

        result[i] = trimmedNums[k - 1].index;

        free(trimmedNums);
    }

    return result;
}