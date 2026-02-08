#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSum(int* nums, int numsSize) {
    int max_sum = -1;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int max_digit_i = 0;
            int temp_i = nums[i];
            while (temp_i > 0) {
                int digit = temp_i % 10;
                if (digit > max_digit_i) {
                    max_digit_i = digit;
                }
                temp_i /= 10;
            }

            int max_digit_j = 0;
            int temp_j = nums[j];
            while (temp_j > 0) {
                int digit = temp_j % 10;
                if (digit > max_digit_j) {
                    max_digit_j = digit;
                }
                temp_j /= 10;
            }

            if (max_digit_i == max_digit_j) {
                if (nums[i] + nums[j] > max_sum) {
                    max_sum = nums[i] + nums[j];
                }
            }
        }
    }
    return max_sum;
}