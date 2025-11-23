#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubarrays(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int currentAnd = nums[i];
        if (currentAnd == k) {
            count++;
        }
        for (int j = i + 1; j < numsSize; j++) {
            currentAnd &= nums[j];
            if (currentAnd == k) {
                count++;
            }
        }
    }
    return count;
}