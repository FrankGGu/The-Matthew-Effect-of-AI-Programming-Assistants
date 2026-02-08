#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSubarraySumCircular(int* nums, int numsSize) {
    int max_so_far = INT_MIN, max_ending_here = 0;
    int min_so_far = INT_MAX, min_ending_here = 0;
    int total_sum = 0;

    for (int i = 0; i < numsSize; i++) {
        total_sum += nums[i];

        max_ending_here = (max_ending_here + nums[i] > nums[i]) ? (max_ending_here + nums[i]) : nums[i];
        max_so_far = (max_so_far > max_ending_here) ? max_so_far : max_ending_here;

        min_ending_here = (min_ending_here + nums[i] < nums[i]) ? (min_ending_here + nums[i]) : nums[i];
        min_so_far = (min_so_far < min_ending_here) ? min_so_far : min_ending_here;
    }

    if (max_so_far > 0) {
        return (max_so_far > total_sum - min_so_far) ? max_so_far : (total_sum - min_so_far);
    } else {
        return max_so_far;
    }
}