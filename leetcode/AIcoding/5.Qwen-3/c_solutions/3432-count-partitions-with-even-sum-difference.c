#include <stdio.h>
#include <stdlib.h>

long long countPartitions(int* nums, int numsSize) {
    long long totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    long long prefixSum = 0;
    long long count = 0;

    for (int i = 0; i < numsSize - 1; i++) {
        prefixSum += nums[i];
        long long suffixSum = totalSum - prefixSum;
        if ((prefixSum - suffixSum) % 2 == 0) {
            count++;
        }
    }

    return count;
}