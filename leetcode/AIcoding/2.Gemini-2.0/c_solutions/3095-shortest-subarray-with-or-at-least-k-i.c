#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shortestSubarray(int* nums, int numsSize, int k) {
    int left = 0, right = 0, minLen = INT_MAX, currentOr = 0;

    while (right < numsSize) {
        currentOr |= nums[right];

        while (currentOr >= k) {
            if (right - left + 1 < minLen) {
                minLen = right - left + 1;
            }

            currentOr ^= nums[left];
            left++;
        }

        right++;
    }

    return (minLen == INT_MAX) ? -1 : minLen;
}