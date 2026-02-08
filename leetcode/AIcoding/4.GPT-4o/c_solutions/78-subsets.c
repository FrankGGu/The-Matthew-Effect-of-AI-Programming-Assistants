#include <stdlib.h>

void backtrack(int** res, int* returnSize, int* nums, int numsSize, int* tempList, int tempListSize, int start) {
    res[*returnSize] = (int*)malloc(sizeof(int) * tempListSize);
    for (int i = 0; i < tempListSize; i++) {
        res[*returnSize][i] = tempList[i];
    }
    (*returnSize)++;

    for (int i = start; i < numsSize; i++) {
        tempList[tempListSize] = nums[i];
        backtrack(res, returnSize, nums, numsSize, tempList, tempListSize + 1, i + 1);
    }
}

int** subsets(int* nums, int numsSize, int* returnSize) {
    int maxSize = 1 << numsSize;
    int** res = (int**)malloc(sizeof(int*) * maxSize);
    *returnSize = 0;
    int* tempList = (int*)malloc(sizeof(int) * numsSize);
    backtrack(res, returnSize, nums, numsSize, tempList, 0, 0);
    free(tempList);
    return res;
}