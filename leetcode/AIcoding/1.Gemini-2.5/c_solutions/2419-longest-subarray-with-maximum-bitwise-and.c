#include <stddef.h> // For size_t

int longestSubarray(int* nums, int numsSize) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    int max_subarray_length = 0;
    int current_length = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == max_val) {
            current_length++;
        } else {
            current_length = 0;
        }
        if (current_length > max_subarray_length) {
            max_subarray_length = current_length;
        }
    }

    return max_subarray_length;
}