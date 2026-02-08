#include <stdio.h>
#include <stdlib.h>

int maxErasableSubarraySum(int* nums, int numsSize) {
    int maxSum = 0;
    int left = 0;
    int sum = 0;
    int freq[10001] = {0};

    for (int right = 0; right < numsSize; right++) {
        while (freq[nums[right]] > 0) {
            sum -= nums[left];
            freq[nums[left]]--;
            left++;
        }
        sum += nums[right];
        freq[nums[right]]++;
        if (sum > maxSum) {
            maxSum = sum;
        }
    }

    return maxSum;
}