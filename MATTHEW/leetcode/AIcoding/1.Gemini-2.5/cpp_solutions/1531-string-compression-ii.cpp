#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int get_len(int count) {
        if (count == 0) return 0;
        if (count == 1) return 1;
        if (count < 10) return 2;
        if (count < 100) return 3;
        return 4;
    }

    int getLengthOfOptimalCompression(std::string s, int k) {
        int n = s.length();
        // dp[i][j] stores the minimum compressed length for the prefix s[0...i-1]
        // after deleting exactly j characters.
        std::vector<std::vector<int>> dp(n + 1, std::vector<int>(k + 1, n + 1));

        // Base case: empty prefix, 0 deletions, length 0.
        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) { // Current prefix length, considering s[i-1]
            for (int j = 0; j <= k; ++j) { // Number of deletions allowed so far

                // Option 1: Delete s[i-1]
                if (j > 0) {
                    dp[i][j] = dp[i-1][j-1];
                }

                // Option 2: Keep s[i-1] and form a block with preceding characters
                // Iterate backwards from i-1 to find the start of the current block
                int count_char = 0; // Count of s[i-1] in the current segment s[p...i-1]
                int count_other = 0; // Count of other characters in s[p...i-1] (these must be deleted)

                for (int p = i - 1; p >= 0; --p) { // p is the start index of the current block
                    if (s[p] == s[i-1]) {
                        count_char++;
                    } else {
                        count_other++;
                    }

                    if (count_other <= j) { // If we have enough deletions to remove 'count_other' characters
                        dp[i][j] = std::min(dp[i][j], dp[p][j - count_other] + get_len(count_char));
                    } else {
                        // Not enough deletions, no need to go further back
                        break;
                    }
                }
            }
        }

        return dp[n][k];
    }
};