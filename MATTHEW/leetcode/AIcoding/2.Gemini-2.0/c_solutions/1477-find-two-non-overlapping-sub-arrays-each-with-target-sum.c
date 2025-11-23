#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSubArrayLen(int* nums, int numsSize, int target) {
    int minLen = INT_MAX;
    int left = 0;
    int sum = 0;
    for (int right = 0; right < numsSize; right++) {
        sum += nums[right];
        while (sum >= target) {
            int len = right - left + 1;
            if (len < minLen) {
                minLen = len;
            }
            sum -= nums[left];
            left++;
        }
    }
    return (minLen == INT_MAX) ? INT_MAX : minLen;
}

int findTwoNonOverlappingSubArrays(int* arr, int arrSize, int target) {
    int minLen[arrSize];
    minLen[0] = INT_MAX;
    int left = 0;
    int sum = 0;
    int minSoFar = INT_MAX;
    for (int i = 0; i < arrSize; i++) {
        sum += arr[i];
        while (sum >= target) {
            int len = i - left + 1;
            if (len < minSoFar) {
                minSoFar = len;
            }
            sum -= arr[left];
            left++;
        }
        minLen[i] = minSoFar;
    }

    int rightMin[arrSize];
    rightMin[arrSize - 1] = INT_MAX;
    left = arrSize - 1;
    sum = 0;
    minSoFar = INT_MAX;
    for (int i = arrSize - 1; i >= 0; i--) {
        sum += arr[i];
        while (sum >= target) {
            int len = left - i + 1;
            if (len < minSoFar) {
                minSoFar = len;
            }
            sum -= arr[left];
            left--;
        }
        rightMin[i] = minSoFar;
    }

    int minSum = INT_MAX;
    for (int i = 0; i < arrSize - 1; i++) {
        if (minLen[i] != INT_MAX && rightMin[i + 1] != INT_MAX) {
            int currentSum = minLen[i] + rightMin[i + 1];
            if (currentSum < minSum) {
                minSum = currentSum;
            }
        }
    }

    return (minSum == INT_MAX) ? -1 : minSum;
}