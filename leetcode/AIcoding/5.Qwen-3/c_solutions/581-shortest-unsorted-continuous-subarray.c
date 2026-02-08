#include <stdio.h>
#include <stdlib.h>

int findUnsortedSubarray(int* nums, int numsSize) {
    int n = numsSize;
    int start = 0, end = n - 1;

    while (start < n - 1 && nums[start] <= nums[start + 1]) {
        start++;
    }

    if (start == n - 1) {
        return 0;
    }

    while (end > 0 && nums[end] >= nums[end - 1]) {
        end--;
    }

    int min = nums[start], max = nums[start];
    for (int i = start; i <= end; i++) {
        if (nums[i] < min) {
            min = nums[i];
        }
        if (nums[i] > max) {
            max = nums[i];
        }
    }

    while (start >= 0 && nums[start] > min) {
        start--;
    }

    while (end < n && nums[end] < max) {
        end++;
    }

    return end - start - 1;
}