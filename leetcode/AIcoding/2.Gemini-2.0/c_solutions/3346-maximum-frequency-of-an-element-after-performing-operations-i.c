#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int maxFrequency(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int left = 0, right = 0;
    long long sum = 0;
    int max_freq = 0;

    while (right < numsSize) {
        sum += nums[right];

        while ((long long)nums[right] * (right - left + 1) > sum + k) {
            sum -= nums[left];
            left++;
        }

        max_freq = (right - left + 1) > max_freq ? (right - left + 1) : max_freq;
        right++;
    }

    return max_freq;
}