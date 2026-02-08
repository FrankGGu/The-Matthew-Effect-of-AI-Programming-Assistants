#include <stdlib.h> // For labs
#include <limits.h> // For LLONG_MAX

int minimumAverageDifference(int* nums, int numsSize) {
    long long total_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        total_sum += nums[i];
    }

    long long min_avg_diff = LLONG_MAX;
    int result_index = -1;

    long long current_prefix_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        current_prefix_sum += nums[i];

        long long avg1 = current_prefix_sum / (i + 1);

        long long avg2;
        int count2 = numsSize - (i + 1);
        if (count2 == 0) {
            avg2 = 0;
        } else {
            avg2 = (total_sum - current_prefix_sum) / count2;
        }

        long long current_diff = labs(avg1 - avg2);

        if (current_diff < min_avg_diff) {
            min_avg_diff = current_diff;
            result_index = i;
        }
    }

    return result_index;
}