#include <stdio.h>
#include <stdlib.h>

int numSubarraysWithSum(int* nums, int numsSize, int k) {
    int count = 0;
    int prefixSum = 0;
    int* sumCount = (int*)calloc(numsSize + 1, sizeof(int));
    sumCount[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        prefixSum += nums[i];
        if (prefixSum >= k) {
            count += sumCount[prefixSum - k];
        }
        sumCount[prefixSum]++;
    }

    free(sumCount);
    return count;
}