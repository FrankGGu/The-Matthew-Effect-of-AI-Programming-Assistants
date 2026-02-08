#include <stdio.h>
#include <stdlib.h>

int countSubarrays(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int maxVal = nums[i];
        for (int j = i; j < numsSize; j++) {
            if (nums[j] > maxVal) {
                maxVal = nums[j];
                count++;
            } else {
                break;
            }
        }
    }
    return count;
}