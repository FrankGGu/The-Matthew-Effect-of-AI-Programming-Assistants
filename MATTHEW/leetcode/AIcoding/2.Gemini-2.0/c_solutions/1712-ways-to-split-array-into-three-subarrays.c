#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int waysToSplit(int* nums, int numsSize) {
    int mod = 1000000007;
    int prefixSum[numsSize];
    prefixSum[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        prefixSum[i] = prefixSum[i - 1] + nums[i];
    }

    int count = 0;
    for (int i = 0; i < numsSize - 2; i++) {
        int leftSum = prefixSum[i];
        int left = i + 1;
        int right = numsSize - 2;
        int lowerBound = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            int midSum = prefixSum[mid] - leftSum;
            if (midSum >= leftSum) {
                lowerBound = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        left = i + 1;
        right = numsSize - 2;
        int upperBound = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            int midSum = prefixSum[mid] - leftSum;
            int rightSum = prefixSum[numsSize - 1] - prefixSum[mid];
            if (midSum <= rightSum) {
                upperBound = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (lowerBound != -1 && upperBound != -1 && lowerBound <= upperBound) {
            count = (count + (upperBound - lowerBound + 1)) % mod;
        }
    }

    return count;
}