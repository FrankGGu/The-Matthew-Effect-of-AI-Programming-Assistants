#include <stdio.h>
#include <stdlib.h>

void rotate(int* nums, int numsSize, int k) {
    if (numsSize == 0 || k == 0) return;
    k = k % numsSize;
    int* temp = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        temp[i] = nums[numsSize - k + i];
    }
    for (int i = numsSize - 1; i >= k; i--) {
        nums[i] = nums[i - k];
    }
    for (int i = 0; i < k; i++) {
        nums[i] = temp[i];
    }
    free(temp);
}