#include <string.h>

char findKthCharacter(char* s, int current_idx, long long k) {
    // Base case: If we are at the first character (s[0]), it's always the answer.
    // The string T_0 is just s[0], so its length is 1. k must be 1.
    if (current_idx == 0) {
        return s[0];
    }

    // Calculate the length of the string generated at the previous step (T_{current_idx-1}).
    // The length L[i] of the string after processing s[i] follows the formula: L[i] = 3 * 2^i - 2.
    // So, L[current_idx-1] = 3 * 2^(current_idx-1) - 2.
    // Using bit shift for 2^(current_idx-1) is an efficient way to calculate 3 * 2^(current_idx-1).
    long long prev_len = (3LL << (current_idx - 1)) - 2;

    // The current string T_current_idx is formed as:
    // T_{current_idx-1} + s[current_idx] + reverse(T_{current_idx-1}) + s[current_idx]
    // Let's denote these four parts as P1, P2, P3, P4.
    // P1: T_{current_idx-1} (length prev_len)
    // P2: s[current_idx] (length 1)
    // P3: reverse(T_{current_idx-1}) (length prev_len)
    // P4: s[current_idx] (length 1)

    // Case 1: k falls into the first T_{current_idx-1} segment (P1).
    // This segment covers 1-indexed positions [1, prev_len].
    if (k <= prev_len) {
        return findKthCharacter(s, current_idx - 1, k);
    }
    // Case 2: k is the character s[current_idx] (first occurrence, P2).
    // This is at 1-indexed position (prev_len + 1).
    else if (k == prev_len + 1) {
        return s[current_idx];
    }
    // Case 3: k falls into the reverse(T_{current_idx-1}) segment (P3).
    // This segment covers 1-indexed positions [prev_len + 2, prev_len + 1 + prev_len].
    else if (k <= prev_len + 1 + prev_len) {
        // Calculate the 1-indexed position within the reverse(T_{current_idx-1}) segment.
        // The start of P3 is (prev_len + 1) + 1 = prev_len + 2.
        // So, k_in_reversed_segment = k - (prev_len + 1).
        long long k_in_reversed_segment = k - (prev_len + 1);

        // If we want the j-th character (1-indexed) of reverse(X), it corresponds to the
        // (length(X) - j + 1)-th character (1-indexed) of the original string X.
        // Here, X is T_{current_idx-1}, so its length is prev_len.
        // The new k for T_{current_idx-1} is (prev_len - k_in_reversed_segment + 1).
        long long new_k = prev_len - k_in_reversed_segment + 1;
        return findKthCharacter(s, current_idx - 1, new_k);
    }
    // Case 4: k is the character s[current_idx] (second occurrence, P4).
    // This is at 1-indexed position (prev_len + 1 + prev_len + 1).
    else { // k == prev_len + 1 + prev_len + 1
        return s[current_idx];
    }
}

char findKthCharacterInStringGameII(char* s, int n, long long k) {
    // The problem asks for the k-th character of the final string after n-1 steps.
    // This corresponds to the string T_{n-1}.
    // The recursive function `findKthCharacter` takes the current step index (0 to n-1)
    // and the 1-indexed position k.
    return findKthCharacter(s, n - 1, k);
}