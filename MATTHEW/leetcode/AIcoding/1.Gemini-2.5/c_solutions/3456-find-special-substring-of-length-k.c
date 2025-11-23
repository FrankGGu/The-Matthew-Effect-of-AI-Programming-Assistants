#include <string.h>
#include <stdlib.h> // Required for malloc if VLAs are not supported or preferred

int findSpecialSubstring(char * s, int k) {
    int n = strlen(s);
    if (k <= 0 || k > n) {
        return 0;
    }

    int count = 0;

    // Precompute run lengths
    int *left_run = (int *)malloc(n * sizeof(int));
    int *right_run = (int *)malloc(n * sizeof(int));

    if (n > 0) {
        left_run[0] = 1;
        for (int i = 1; i < n; i++) {
            if (s[i] == s[i-1]) {
                left_run[i] = left_run[i-1] + 1;
            } else {
                left_run[i] = 1;
            }
        }

        right_run[n-1] = 1;
        for (int i = n - 2; i >= 0; i--) {
            if (s[i] == s[i+1]) {
                right_run[i] = right_run[i+1] + 1;
            } else {
                right_run[i] = 1;
            }
        }
    }

    // Type 1: All characters are the same
    for (int i = 0; i < n; ) {
        int current_run_len = right_run[i];
        if (current_run_len >= k) {
            count += (current_run_len - k + 1);
        }
        i += current_run_len;
    }

    // Type 2: All characters are the same except for the middle one (only if K is odd)
    if (k % 2 == 1) {
        int mid_len = k / 2; // Length of the repeating character block on one side

        for (int i = mid_len; i < n - mid_len; i++) { // i is the center index
            // Check if characters immediately around the center are the same
            // and different from the center character
            if (s[i-1] == s[i+1] && s[i-1] != s[i]) {
                // Check if the repeating blocks are long enough to form a substring of length K
                if (left_run[i-1] >= mid_len && right_run[i+1] >= mid_len) {
                    count++;
                }
            }
        }
    }

    free(left_run);
    free(right_run);

    return count;
}