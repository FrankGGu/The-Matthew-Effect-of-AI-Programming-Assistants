#include <stdlib.h> // Required for calloc and free

int minKBitFlips(int* nums, int numsSize, int k) {
    int n = numsSize;
    int total_flips = 0;
    int current_active_flips = 0;

    int* is_flipped_start = (int*)calloc(n, sizeof(int)); 

    for (int i = 0; i < n; ++i) {
        if (i >= k) {
            if (is_flipped_start[i - k] == 1) {
                current_active_flips--;
            }
        }

        if ((nums[i] + current_active_flips) % 2 == 0) {
            if (i + k > n) {
                free(is_flipped_start);
                return -1;
            }

            total_flips++;
            current_active_flips++;
            is_flipped_start[i] = 1;
        }
    }

    free(is_flipped_start);
    return total_flips;
}