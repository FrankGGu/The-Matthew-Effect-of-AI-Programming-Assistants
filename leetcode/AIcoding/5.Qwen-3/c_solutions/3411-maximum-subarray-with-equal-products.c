#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxSubarraySum(int* nums, int numsSize) {
    int max_sum = INT_MIN;
    int current_sum = 0;
    int product = 1;
    int zero_count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            zero_count++;
            if (zero_count > 1) {
                current_sum = 0;
                product = 1;
                zero_count = 1;
            }
        } else {
            if (nums[i] > 0) {
                current_sum += nums[i];
                product *= nums[i];
            } else {
                current_sum += nums[i];
                product *= nums[i];
            }
        }

        if (product > 0) {
            max_sum = (current_sum > max_sum) ? current_sum : max_sum;
        } else if (product < 0) {
            max_sum = (current_sum > max_sum) ? current_sum : max_sum;
        } else {
            max_sum = (0 > max_sum) ? 0 : max_sum;
        }
    }

    return max_sum;
}