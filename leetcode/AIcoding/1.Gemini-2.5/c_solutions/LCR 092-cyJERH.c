#include <string.h> // For strlen
#include <stdlib.h> // For min, though a custom min is often preferred in competitive programming

int min(int a, int b) {
    return a < b ? a : b;
}

int minFlipsMonoIncr(char * s){
    int n = strlen(s);

    // dp0: minimum flips to make the prefix s[0...i] all '0's.
    // dp1: minimum flips to make the prefix s[0...i] monotone increasing and ending with '1'.
    // Initialize for an empty prefix (before processing any character).
    // An empty prefix requires 0 flips to be all '0's or monotone ending in '1'.
    int dp0 = 0;
    int dp1 = 0;

    for (int i = 0; i < n; i++) {
        char c = s[i];

        int next_dp0, next_dp1;

        if (c == '0') {
            // If the current character s[i] is '0':
            // To make the prefix s[0...i] all '0's:
            // We don't need to flip s[i]. The cost is the same as making s[0...i-1] all '0's.
            next_dp0 = dp0; 

            // To make the prefix s[0...i] monotone increasing ending with '1':
            // We must flip s[i] from '0' to '1'. This adds 1 flip.
            // The previous prefix s[0...i-1] could have been all '0's (cost dp0)
            // or monotone increasing ending with '1' (cost dp1).
            // We take the minimum of these two previous states and add 1 for the current flip.
            next_dp1 = min(dp0, dp1) + 1;
        } else { // c == '1'
            // If the current character s[i] is '1':
            // To make the prefix s[0...i] all '0's:
            // We must flip s[i] from '1' to '0'. This adds 1 flip.
            // The cost is the cost of making s[0...i-1] all '0's plus 1.
            next_dp0 = dp0 + 1;

            // To make the prefix s[0...i] monotone increasing ending with '1':
            // We don't need to flip s[i]. The cost is the minimum of:
            // 1. Making s[0...i-1] all '0's (cost dp0).
            // 2. Making s[0...i-1] monotone increasing ending with '1' (cost dp1).
            next_dp1 = min(dp0, dp1);
        }

        // Update dp states for the next iteration
        dp0 = next_dp0;
        dp1 = next_dp1;
    }

    // After iterating through all characters, the minimum flips is the minimum of:
    // 1. The cost to make the entire string all '0's (represented by dp0).
    // 2. The cost to make the entire string monotone increasing ending with '1' (represented by dp1).
    return min(dp0, dp1);
}