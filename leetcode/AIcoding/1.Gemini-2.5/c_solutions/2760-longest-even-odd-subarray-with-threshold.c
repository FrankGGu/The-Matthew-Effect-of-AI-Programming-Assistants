#include <stdlib.h> // Required for max, or define a custom max function

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int longestEvenOddSubarray(int* nums, int numsSize, int threshold) {
    int max_len = 0;
    int current_len = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > threshold) {
            current_len = 0;
        } else {
            if (current_len == 0) {
                if (nums[i] % 2 == 0) {
                    current_len = 1;
                    max_len = max(max_len, current_len);
                }
            } else {
                if ((nums[i] % 2) != (nums[i-1] % 2)) {
                    current_len++;
                    max_len = max(max_len, current_len);
                } else {
                    if (nums[i] % 2 == 0) {
                        current_len = 1;
                        max_len = max(max_len, current_len);
                    } else {
                        current_len = 0;
                    }
                }
            }
        }
    }

    return max_len;
}