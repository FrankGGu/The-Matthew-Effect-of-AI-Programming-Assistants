#include <string.h> // For strlen and memset

int min(int a, int b) {
    return a < b ? a : b;
}

int getLen(int count) {
    if (count == 0) return 0;
    if (count == 1) return 1; // e.g., 'a'
    if (count < 10) return 2; // e.g., 'a2'
    if (count < 100) return 3; // e.g., 'a10'
    return 4; // e.g., 'a100' (max count is 100 for N=100)
}

int getLengthOfOptimalCompression(char * s, int k){
    int n = strlen(s);

    // dp[i][j] = minimum length to compress the prefix s[0...i-1]
    //            after deleting exactly j characters.
    // Dimensions: (n+1) x (k+1)
    // Max n is 100, max k is 100. So 101x101 array.
    int dp[101][101]; 

    // Initialize dp table with a large value representing infinity.
    // 0x3f is a common value in competitive programming, as 0x3f3f3f3f is
    // approximately 10^9, which is large enough but won't overflow when added.
    memset(dp, 0x3f, sizeof(dp));

    // Base case: An empty string (prefix of length 0) with 0 deletions has 0 compressed length.
    dp[0][0] = 0;

    // Iterate through prefix lengths (from 1 to n)
    for (int i = 1; i <= n; ++i) {
        // Iterate through possible number of deletions (from 0 to k)
        for (int j = 0; j <= k; ++j) {
            // Option 1: Delete the current character s[i-1]
            // This is possible only if we have at least one deletion available (j > 0).
            if (j > 0) {
                dp[i][j] = min(dp[i][j], dp[i-1][j-1]);
            }

            // Option 2: Keep the current character s[i-1] and make it the end of a block.
            // We iterate backwards from s[i-1] to find the start of this block.
            int cnt_same = 0; // Count of characters identical to s[i-1] within the current block
            int cnt_diff = 0; // Count of characters different from s[i-1] within the current block
            char current_char = s[i-1]; // The character that defines this block

            // Loop to find the optimal start (prev_i) for the current block ending at s[i-1]
            for (int prev_i = i - 1; prev_i >= 0; --prev_i) {
                if (s[prev_i] == current_char) {
                    cnt_same++;
                } else {
                    cnt_diff++;
                }

                // If we have enough deletions (j) to remove all 'different' characters (cnt_diff)
                // within the current block s[prev_i...i-1]:
                if (j >= cnt_diff) {
                    // The cost for the prefix s[0...prev_i-1] would be dp[prev_i][j - cnt_diff].
                    // Add the compressed length of the current block (cnt_same).
                    dp[i][j] = min(dp[i][j], dp[prev_i][j - cnt_diff] + getLen(cnt_same));
                }
            }
        }
    }

    // The result is the minimum compressed length for the entire string s (length n)
    // after deleting exactly k characters.
    return dp[n][k];
}