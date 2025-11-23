#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)b - *(int *)a;
}

int matrixSum(int** nums, int numsSize, int* numsColSize){
    int sum = 0;
    int cols = *numsColSize;

    for (int j = 0; j < cols; j++) {
        int max_val = 0;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i][j] > max_val) {
                max_val = nums[i][j];
            }
        }
        sum += max_val;
    }
    return sum;
}