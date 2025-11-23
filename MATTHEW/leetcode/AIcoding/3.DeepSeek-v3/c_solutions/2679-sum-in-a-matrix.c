#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

int matrixSum(int** nums, int numsSize, int* numsColSize) {
    for (int i = 0; i < numsSize; i++) {
        qsort(nums[i], numsColSize[i], sizeof(int), compare);
    }

    int score = 0;
    for (int j = 0; j < numsColSize[0]; j++) {
        int maxVal = 0;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i][j] > maxVal) {
                maxVal = nums[i][j];
            }
        }
        score += maxVal;
    }

    return score;
}