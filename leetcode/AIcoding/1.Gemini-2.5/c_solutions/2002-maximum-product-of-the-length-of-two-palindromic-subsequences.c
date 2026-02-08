#include <string.h>
#include <stdlib.h> // For calloc, free

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int maxProduct(char * s){
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    // lps_len[mask] stores the length of the longest palindromic subsequence
    // for the subsequence formed by characters at indices specified by mask.
    int* lps_len = (int*) calloc(1 << n, sizeof(int));
    if (lps_len == NULL) {
        // Memory allocation failed. In competitive programming, often ignored.
        return 0; 
    }

    // Precompute LPS length for all possible subsequences (represented by masks)
    for (int mask = 1; mask < (1 << n); ++mask) {
        // Find the index of the first (least significant) and last (most significant) set bit in the mask.
        // These correspond to the first and last characters of the subsequence.
        int first_char_idx = __builtin_ctz(mask); // Count trailing zeros to find LSB position
        int last_char_idx = (sizeof(int) * 8 - 1) - __builtin_clz(mask); // Count leading zeros to find MSB position

        if (first_char_idx == last_char_idx) { // Mask has only one bit set (single character subsequence)
            lps_len[mask] = 1;
        } else {
            if (s[first_char_idx] == s[last_char_idx]) {
                // If the first and last characters of the subsequence match,
                // they can form an outer pair of the palindrome.
                // The remaining palindrome length comes from the sub-mask excluding these two.
                int sub_mask = mask ^ (1 << first_char_idx) ^ (1 << last_char_idx);
                lps_len[mask] = 2 + lps_len[sub_mask];
            } else {
                // If they don't match, we must exclude either the first or the last character
                // and take the maximum LPS length from the resulting sub-masks.
                int sub_mask1 = mask ^ (1 << first_char_idx); // Exclude first_char_idx
                int sub_mask2 = mask ^ (1 << last_char_idx);  // Exclude last_char_idx
                lps_len[mask] = max(lps_len[sub_mask1], lps_len[sub_mask2]);
            }
        }
    }

    int max_product = 0;

    // Iterate through all possible ways to partition the original string's indices
    // into two non-empty subsequences.
    // mask1 represents the indices for the first subsequence.
    // mask2 represents the indices for the second subsequence (complement of mask1).
    // The loop iterates mask1 from 1 up to (1 << n) - 2.
    // This ensures that both mask1 and mask2 are always non-empty.
    for (int mask1 = 1; mask1 < (1 << n) - 1; ++mask1) { 
        int mask2 = ((1 << n) - 1) ^ mask1; // mask2 is the complement of mask1

        // Calculate the product of the LPS lengths for the two subsequences
        // and update max_product if it's greater.
        max_product = max(max_product, lps_len[mask1] * lps_len[mask2]);
    }

    free(lps_len);
    return max_product;
}