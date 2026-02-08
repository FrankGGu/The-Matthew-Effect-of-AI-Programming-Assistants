#include <string.h>
#include <stdlib.h> // For max, or define a simple max function

int max(int a, int b) {
    return a > b ? a : b;
}

int longestSemiRepetitiveSubstring(char * s){
    int n = strlen(s);
    if (n <= 1) {
        return n;
    }

    int left = 0;
    // bad_pairs counts the number of positions k such that s[k] == s[k+1]
    // Based on the problem examples (e.g., "52233" -> 4, "AAAAA" -> 2),
    // a semi-repetitive substring must have at most ONE such pair.
    // The problem description "at most two adjacent identical characters" is misleading.
    int bad_pairs = 0; 
    int max_len = 0;

    for (int right = 0; right < n; right++) {
        // When expanding the window to the right, check if s[right-1] and s[right] form a bad pair
        if (right > 0 && s[right] == s[right-1]) {
            bad_pairs++;
        }

        // If the number of bad pairs exceeds the limit (which is 1, based on examples)
        // Shrink the window from the left until the condition is met again.
        while (bad_pairs > 1) {
            // When shrinking, check if the pair s[left] and s[left+1] was a bad pair
            // If it was, decrement bad_pairs as it's no longer part of the window
            if (s[left] == s[left+1]) {
                bad_pairs--;
            }
            left++;
        }

        // Update max_len with the current valid window length
        // The window is [left, right], so its length is right - left + 1
        max_len = max(max_len, right - left + 1);
    }

    return max_len;
}