#include <stddef.h> // For NULL, size_t

int longestOnes(int* nums, int numsSize, int k) {
    int left = 0;
    int zero_count = 0;
    int max_len = 0;

    for (int right = 0; right < numsSize; right++) {
        if (nums[right] == 0) {
            zero_count++;
        }

        while (zero_count > k) {
            if (nums[left] == 0) {
                zero_count--;
            }
            left++;
        }

        int current_len = right - left + 1;
        if (current_len > max_len) {
            max_len = current_len;
        }
    }

    return max_len;
}