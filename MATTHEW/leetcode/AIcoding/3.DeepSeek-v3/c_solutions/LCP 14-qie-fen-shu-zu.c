#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define MIN(a, b) ((a) < (b) ? (a) : (b))

int splitArray(int* nums, int numsSize) {
    int max_num = 0;
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        max_num = (nums[i] > max_num) ? nums[i] : max_num;
        sum += nums[i];
    }

    long long left = max_num;
    long long right = sum;

    while (left < right) {
        long long mid = left + (right - left) / 2;
        int count = 1;
        long long current_sum = 0;

        for (int i = 0; i < numsSize; i++) {
            if (current_sum + nums[i] > mid) {
                count++;
                current_sum = nums[i];
            } else {
                current_sum += nums[i];
            }
        }

        if (count > 1) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return (int)left;
}