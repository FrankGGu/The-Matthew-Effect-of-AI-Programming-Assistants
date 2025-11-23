#include <limits.h>

int minimumElementAfterReplacement(int* nums, int numsSize) {
    int min_val = INT_MAX;

    for (int i = 0; i < numsSize; i++) {
        int current_num = nums[i];

        // Calculate the digital root for positive integers
        // The digital root of a positive integer n is (n - 1) % 9 + 1
        int digital_root = (current_num - 1) % 9 + 1;

        if (digital_root < min_val) {
            min_val = digital_root;
        }
    }

    return min_val;
}