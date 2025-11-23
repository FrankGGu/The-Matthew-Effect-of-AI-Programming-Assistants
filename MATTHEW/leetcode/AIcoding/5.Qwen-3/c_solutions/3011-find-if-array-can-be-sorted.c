#include <stdio.h>
#include <stdlib.h>

bool canBeSorted(int* nums, int numsSize) {
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }
    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = 0; j < numsSize - i - 1; j++) {
            if (sorted[j] > sorted[j + 1]) {
                int temp = sorted[j];
                sorted[j] = sorted[j + 1];
                sorted[j + 1] = temp;
            }
        }
    }
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != sorted[i]) {
            free(sorted);
            return false;
        }
    }
    free(sorted);
    return true;
}