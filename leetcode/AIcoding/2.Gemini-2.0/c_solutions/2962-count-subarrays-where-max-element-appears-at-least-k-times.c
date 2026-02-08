#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubarrays(int* nums, int numsSize, int k) {
    int maxNum = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    long long count = 0;
    for (int i = 0; i < numsSize; i++) {
        int maxCount = 0;
        for (int j = i; j < numsSize; j++) {
            if (nums[j] == maxNum) {
                maxCount++;
            }
            if (maxCount >= k) {
                count++;
            }
        }
    }

    return (int)count;
}