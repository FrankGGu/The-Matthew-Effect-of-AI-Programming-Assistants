#include <stdio.h>
#include <stdlib.h>

int numberOfSubarrays(int* nums, int numsSize, int k, int threshold) {
    int sum = 0;
    for (int i = 0; i < k; i++) {
        sum += nums[i];
    }
    int count = 0;
    if (sum / k >= threshold) {
        count++;
    }
    for (int i = k; i < numsSize; i++) {
        sum += nums[i] - nums[i - k];
        if (sum / k >= threshold) {
            count++;
        }
    }
    return count;
}