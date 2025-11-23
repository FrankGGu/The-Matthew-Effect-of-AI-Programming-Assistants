#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maximumSum(int* nums, int numsSize, int m, int k) {
    long long maxSum = 0;
    long long currentSum = 0;
    int uniqueCount = 0;
    int freq[100001] = {0};

    for (int i = 0; i < k; i++) {
        if (freq[nums[i]] == 0) {
            uniqueCount++;
        }
        freq[nums[i]]++;
        currentSum += nums[i];
    }

    if (uniqueCount >= m) {
        maxSum = currentSum;
    }

    for (int i = k; i < numsSize; i++) {
        freq[nums[i - k]]--;
        if (freq[nums[i - k]] == 0) {
            uniqueCount--;
        }

        if (freq[nums[i]] == 0) {
            uniqueCount++;
        }
        freq[nums[i]]++;

        currentSum = currentSum - nums[i - k] + nums[i];

        if (uniqueCount >= m) {
            if (currentSum > maxSum) {
                maxSum = currentSum;
            }
        }
    }

    return maxSum;
}