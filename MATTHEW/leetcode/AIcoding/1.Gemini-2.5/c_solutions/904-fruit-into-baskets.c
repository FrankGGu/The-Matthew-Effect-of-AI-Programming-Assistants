#include <stdlib.h> // Required for general utilities, though not strictly for this specific solution's logic.

#define MAX_FRUIT_TYPE_VALUE 100001

int totalFruit(int* fruits, int fruitsSize) {
    if (fruitsSize == 0) {
        return 0;
    }

    int fruit_counts[MAX_FRUIT_TYPE_VALUE] = {0}; // Initialize all counts to 0
    int distinct_count = 0;
    int max_len = 0;
    int left = 0;

    for (int right = 0; right < fruitsSize; right++) {
        // Add fruit at 'right' to the window
        if (fruit_counts[fruits[right]] == 0) {
            distinct_count++;
        }
        fruit_counts[fruits[right]]++;

        // Shrink window from 'left' if more than 2 distinct fruit types
        while (distinct_count > 2) {
            fruit_counts[fruits[left]]--;
            if (fruit_counts[fruits[left]] == 0) {
                distinct_count--;
            }
            left++;
        }

        // Update max_len with the current window size
        // The window size is (right - left + 1)
        if (right - left + 1 > max_len) {
            max_len = right - left + 1;
        }
    }

    return max_len;
}