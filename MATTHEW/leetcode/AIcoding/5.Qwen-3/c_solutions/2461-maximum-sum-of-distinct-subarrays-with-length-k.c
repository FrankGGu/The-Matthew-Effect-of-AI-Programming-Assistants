#include <stdio.h>
#include <stdlib.h>

long long maximumSubarraySum(int* nums, int numsSize, int k) {
    long long maxSum = 0;
    long long currentSum = 0;
    int freq[100001] = {0};
    int uniqueCount = 0;

    for (int i = 0; i < numsSize; i++) {
        if (freq[nums[i]] == 0) {
            uniqueCount++;
        }
        freq[nums[i]]++;
        currentSum += nums[i];

        if (i >= k) {
            int out = nums[i - k];
            freq[out]--;
            if (freq[out] == 0) {
                uniqueCount--;
            }
            currentSum -= out;
        }

        if (i >= k - 1) {
            if (uniqueCount == k) {
                maxSum = (currentSum > maxSum) ? currentSum : maxSum;
            }
        }
    }

    return maxSum;
}