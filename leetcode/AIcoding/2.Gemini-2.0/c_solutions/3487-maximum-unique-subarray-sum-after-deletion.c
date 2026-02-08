#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumUniqueSubarray(int* nums, int numsSize) {
    int freq[10001] = {0};
    int left = 0, right = 0, sum = 0, maxSum = 0;

    while (right < numsSize) {
        while (freq[nums[right]] > 0) {
            freq[nums[left]]--;
            sum -= nums[left];
            left++;
        }

        freq[nums[right]]++;
        sum += nums[right];
        maxSum = (sum > maxSum) ? sum : maxSum;
        right++;
    }

    return maxSum;
}