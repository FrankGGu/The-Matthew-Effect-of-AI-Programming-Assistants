#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize, int k){
    if (nums == NULL || numsSize == 0) {
        return -1;
    }

    long long totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    if (totalSum % k == 0) {
        return 0;
    }

    long long remainder = totalSum % k;
    int minLen = numsSize + 1;
    long long currentSum = 0;
    int start = 0;
    for (int end = 0; end < numsSize; end++) {
        currentSum += nums[end];
        while (currentSum % k == remainder) {
            int len = end - start + 1;
            if (len < minLen) {
                minLen = len;
            }
            currentSum -= nums[start];
            start++;
        }
    }

    if (minLen > numsSize) {
        return -1;
    }

    return minLen;
}