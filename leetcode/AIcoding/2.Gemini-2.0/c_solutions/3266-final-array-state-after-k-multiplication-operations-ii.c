#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getFinalArrayAfterKMultiplicationOperations(int* nums, int numsSize, int k, int queriesSize, int** queries, int* returnSize) {
    for (int i = 0; i < k; i++) {
        int l = queries[i][0];
        int r = queries[i][1];
        int x = queries[i][2];
        for (int j = l; j <= r; j++) {
            nums[j] *= x;
        }
    }
    *returnSize = numsSize;
    return nums;
}