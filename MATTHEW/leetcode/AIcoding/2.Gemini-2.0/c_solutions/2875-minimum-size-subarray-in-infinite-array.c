#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSizeSubarray(int* nums, int numsSize, int target) {
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    long long k = target / sum;
    target %= sum;
    int ans = k * numsSize;
    if (target == 0) return ans;

    int left = 0, right = 0;
    long long curr = 0;
    int minLen = numsSize + 1;

    while (right < 2 * numsSize) {
        curr += nums[right % numsSize];
        while (curr > target) {
            curr -= nums[left % numsSize];
            left++;
        }
        if (curr == target) {
            minLen = (minLen < right - left + 1) ? minLen : right - left + 1;
        }
        right++;
    }

    return (minLen == numsSize + 1) ? -1 : ans + minLen;
}