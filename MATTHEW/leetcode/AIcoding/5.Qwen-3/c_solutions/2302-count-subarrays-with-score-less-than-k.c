#include <stdio.h>
#include <stdlib.h>

long long int sum(int* nums, int start, int end) {
    long long int total = 0;
    for (int i = start; i <= end; i++) {
        total += nums[i];
    }
    return total;
}

int numSubarraysWithScoreLessThanK(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        long long int currentSum = 0;
        for (int j = i; j < numsSize; j++) {
            currentSum += nums[j];
            if (currentSum < k) {
                count++;
            } else {
                break;
            }
        }
    }
    return count;
}