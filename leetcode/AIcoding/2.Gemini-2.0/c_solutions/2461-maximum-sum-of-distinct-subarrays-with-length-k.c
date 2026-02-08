#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maximumSubarraySum(int* nums, int numsSize, int k) {
    long long maxSum = 0;
    long long currentSum = 0;
    int left = 0;
    int right = 0;
    int count = 0;
    int freq[100001] = {0};

    while (right < numsSize) {
        if (freq[nums[right]] == 0) {
            count++;
        }
        freq[nums[right]]++;
        currentSum += nums[right];

        if (right - left + 1 == k) {
            if (count == k) {
                if (currentSum > maxSum) {
                    maxSum = currentSum;
                }
            }
            freq[nums[left]]--;
            if (freq[nums[left]] == 0) {
                count--;
            }
            currentSum -= nums[left];
            left++;
        }
        right++;
    }

    return maxSum;
}