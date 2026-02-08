#include <stdio.h>
#include <stdlib.h>

int maxUniqueSubarraySum(int* nums, int numsSize) {
    int maxSum = 0;
    int left = 0;
    int sum = 0;
    int* hash = (int*)calloc(10001, sizeof(int));

    for (int right = 0; right < numsSize; right++) {
        while (hash[nums[right]] > 0) {
            hash[nums[left]]--;
            sum -= nums[left];
            left++;
        }
        hash[nums[right]]++;
        sum += nums[right];
        if (sum > maxSum) {
            maxSum = sum;
        }
    }

    free(hash);
    return maxSum;
}