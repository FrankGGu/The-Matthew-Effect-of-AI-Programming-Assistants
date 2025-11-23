#include <stddef.h>
#include <stdlib.h> // For max function (not strictly needed, can use if/else)

static int max(int a, int b) {
    return a > b ? a : b;
}

int maximizeActiveSection(int* nums, int numsSize) {
    int left = 0;
    int zero_count = 0;
    int max_len = 0;

    for (int right = 0; right < numsSize; right++) {
        if (nums[right] == 0) {
            zero_count++;
        }

        // Shrink the window from the left if more than one zero is encountered
        // (since we are allowed at most one trade, meaning at most one 0 in the active section)
        while (zero_count > 1) {
            if (nums[left] == 0) {
                zero_count--;
            }
            left++;
        }

        // Update the maximum length found so far
        max_len = max(max_len, right - left + 1);
    }

    return max_len;
}