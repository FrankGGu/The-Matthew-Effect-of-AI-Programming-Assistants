#include <string.h>
#include <stdlib.h> // For abs
#include <limits.h> // For INT_MAX

int calculate_swaps_for_pattern(char* s, int n, char start_char) {
    int mismatches = 0;
    for (int i = 0; i < n; i++) {
        char expected_char = (i % 2 == 0) ? start_char : ('1' - start_char + '0');
        if (s[i] != expected_char) {
            mismatches++;
        }
    }
    return mismatches / 2;
}

int minSwaps(char* s) {
    int n = strlen(s);
    int count0 = 0;
    int count1 = 0;

    // Count the occurrences of '0' and '1'
    for (int i = 0; i < n; i++) {
        if (s[i] == '0') {
            count0++;
        } else {
            count1++;
        }
    }

    // If the difference in counts is greater than 1, it's impossible to form an alternating string.
    if (abs(count0 - count1) > 1) {
        return -1;
    }

    int min_swaps_result = INT_MAX;

    // Case 1: Try to form an alternating string starting with '0' (e.g., "01010...")
    // This is possible if count0 is equal to count1, or count0 is one more than count1.
    if (count0 >= count1) {
        int swaps_for_0_start = calculate_swaps_for_pattern(s, n, '0');
        if (swaps_for_0_start < min_swaps_result) {
            min_swaps_result = swaps_for_0_start;
        }
    }

    // Case 2: Try to form an alternating string starting with '1' (e.g., "10101...")
    // This is possible if count1 is equal to count0, or count1 is one more than count0.
    if (count1 >= count0) {
        int swaps_for_1_start = calculate_swaps_for_pattern(s, n, '1');
        if (swaps_for_1_start < min_swaps_result) {
            min_swaps_result = swaps_for_1_start;
        }
    }

    return min_swaps_result;
}