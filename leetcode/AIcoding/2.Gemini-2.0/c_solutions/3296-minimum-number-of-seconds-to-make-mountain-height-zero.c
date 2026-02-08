#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minimumSeconds(int* nums, int numsSize) {
    long long ans = (long long)numsSize;
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    for (int val = 1; val <= max_val; val++) {
        int last[numsSize + 1];
        for (int i = 0; i <= numsSize; i++) {
            last[i] = -1;
        }

        for (int i = 0; i < numsSize; i++) {
            if (nums[i] == val) {
                last[val] = i;
            }
        }

        int first[numsSize + 1];
        for (int i = 0; i <= numsSize; i++) {
            first[i] = -1;
        }

        for (int i = numsSize - 1; i >= 0; i--) {
            if (nums[i] == val) {
                first[val] = i;
            }
        }

        int intervals[numsSize];
        int count = 0;
        int prev = -1;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] == val) {
                if (prev == -1) {
                    prev = i;
                } else {
                    intervals[count++] = i - prev - 1;
                    prev = i;
                }
            }
        }
        if (count > 0) {
            intervals[count++] = first[val] + numsSize - 1 - last[val];
        } else {
            intervals[count++] = numsSize - 1;
        }

        long long max_interval = 0;
        for (int i = 0; i < count; i++) {
            if (intervals[i] > max_interval) {
                max_interval = intervals[i];
            }
        }

        long long curr_ans = (long long)(numsSize - count) + max_interval / 2;
        if (curr_ans < ans) {
            ans = curr_ans;
        }
    }

    return ans;
}