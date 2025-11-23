#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumAverageDifference(int* nums, int numsSize) {
    long long total_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        total_sum += nums[i];
    }

    long long current_sum = 0;
    int min_avg_diff = INT_MAX;
    int min_index = 0;

    for (int i = 0; i < numsSize; i++) {
        current_sum += nums[i];
        long long first_avg = current_sum / (i + 1);
        long long second_avg = 0;
        if (i < numsSize - 1) {
            second_avg = (total_sum - current_sum) / (numsSize - i - 1);
        }
        int diff = abs(first_avg - second_avg);

        if (diff < min_avg_diff) {
            min_avg_diff = diff;
            min_index = i;
        }
    }

    return min_index;
}