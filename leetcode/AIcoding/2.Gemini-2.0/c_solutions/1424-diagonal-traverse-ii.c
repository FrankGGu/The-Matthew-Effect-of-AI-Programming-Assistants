#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findDiagonalOrder(int** nums, int numsSize, int* numsColSize, int* returnSize){
    int max_len = 0;
    int total_elements = 0;
    for (int i = 0; i < numsSize; i++) {
        total_elements += numsColSize[i];
        if (numsColSize[i] > max_len) {
            max_len = numsColSize[i];
        }
    }

    int* result = (int*)malloc(sizeof(int) * total_elements);
    *returnSize = 0;

    int max_sum = numsSize + max_len - 2;

    for (int sum = 0; sum <= max_sum; sum++) {
        for (int i = numsSize - 1; i >= 0; i--) {
            int j = sum - i;
            if (j >= 0 && j < numsColSize[i]) {
                result[(*returnSize)++] = nums[i][j];
            }
        }
    }

    return result;
}