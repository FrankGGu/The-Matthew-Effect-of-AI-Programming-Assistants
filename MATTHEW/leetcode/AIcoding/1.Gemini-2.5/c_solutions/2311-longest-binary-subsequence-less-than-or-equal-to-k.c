#include <string.h>

int longestSubsequence(char * s, int k){
    int n = strlen(s);
    int zero_count = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '0') {
            zero_count++;
        }
    }

    long long current_val = 0;
    int current_len_of_ones = 0;

    // Iterate from right to left to consider '1's for least significant positions first.
    // This ensures that if we include a '1', it contributes the smallest possible value
    // to the subsequence, maximizing the chance to include more '1's.
    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == '1') {
            // Check if adding this '1' at the current least significant available position
            // (1LL << current_len_of_ones) would exceed k.
            // current_len_of_ones represents the bit position (0-indexed) in the subsequence.
            // Since k is at most 10^9, current_len_of_ones will not exceed ~30-31
            // before current_val exceeds k, so (1LL << current_len_of_ones) will not overflow
            // a long long in this context.
            if (current_val + (1LL << current_len_of_ones) <= k) {
                current_val += (1LL << current_len_of_ones);
                current_len_of_ones++;
            } else {
                // If adding this '1' (which would be at a higher power of 2 than previously chosen '1's)
                // makes the value exceed k, then any '1's to its left in the original string
                // would correspond to even higher powers of 2 (or same, if many 0s were skipped).
                // Thus, they would also exceed k or make it exceed k even more.
                // So, we cannot add any more '1's to maintain value <= k.
                break;
            }
        }
    }

    // The total length is the sum of all '0's (which contribute 0 to value)
    // and the '1's we were able to include without exceeding k.
    return zero_count + current_len_of_ones;
}