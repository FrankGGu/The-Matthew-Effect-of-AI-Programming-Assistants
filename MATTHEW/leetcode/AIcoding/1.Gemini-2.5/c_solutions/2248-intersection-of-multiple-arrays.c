#include <stdlib.h>
#include <string.h>

#define MAX_VAL 1000

int* intersection(int** nums, int numsSize, int* numsColSize, int* returnSize) {
    int counts[MAX_VAL + 1];
    for (int i = 0; i <= MAX_VAL; ++i) {
        counts[i] = 0;
    }

    for (int i = 0; i < numsSize; ++i) {
        for (int j = 0; j < numsColSize[i]; ++j) {
            counts[nums[i][j]]++;
        }
    }

    int* tempResult = (int*)malloc(sizeof(int) * (MAX_VAL + 1));
    int k = 0;

    for (int val = 1; val <= MAX_VAL; ++val) {
        if (counts[val] == numsSize) {
            tempResult[k++] = val;
        }
    }

    *returnSize = k;

    if (k == 0) {
        free(tempResult);
        return NULL;
    }

    int* finalResult = (int*)malloc(sizeof(int) * k);
    memcpy(finalResult, tempResult, sizeof(int) * k);

    free(tempResult);

    return finalResult;
}