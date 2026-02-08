#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void rotate(int* nums, int numsSize, int k){
    k %= numsSize;
    if (k < 0) k += numsSize;

    int temp[k];
    for (int i = 0; i < k; i++) {
        temp[i] = nums[numsSize - k + i];
    }

    for (int i = numsSize - 1; i >= k; i--) {
        nums[i] = nums[i - k];
    }

    for (int i = 0; i < k; i++) {
        nums[i] = temp[i];
    }
}