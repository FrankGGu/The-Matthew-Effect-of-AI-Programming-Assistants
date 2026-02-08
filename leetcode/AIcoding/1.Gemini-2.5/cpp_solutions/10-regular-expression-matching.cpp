#include <string>
#include <vector>

class Solution {
public:
    bool isMatch(std::string s, std::string p) {
        int m = s.length();
        int n = p.length();

        std::vector<std::vector<bool>> dp(m + 1, std::vector<bool>(n + 1, false));

        // Base case: empty string matches empty pattern
        dp[0][0] = true;

        // Fill the first row (s is empty)
        // Only patterns like "a*", "a*b*", "a*b*c*" can match an empty string
        for (int j = 1; j <= n; ++j) {
            if (p[j - 1] == '*') {
                // '*' matches zero occurrences of the preceding element
                // So, p[j-1] and p[j-2] are effectively skipped
                dp[0][j] = dp[0][j - 2];
            }
        }

        // Fill the rest of the DP table
        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                if (p[j - 1] == '*') {
                    // Case 1: '*' matches zero occurrences of the preceding element
                    // This means p[j-1] and p[j-2] are ignored.
                    dp[i][j] = dp[i][j - 2];

                    // Case 2: '*' matches one or more occurrences of the preceding element
                    // Check if s[i-1] matches p[j-2] (the character before '*')
                    if (s[i - 1] == p[j - 2] || p[j - 2] == '.') {
                        // If s[i-1] matches p[j-2], then we can try to match s[0...i-2] with p[0...j-1]
                        // (keeping '*' active to match more occurrences if needed)
                        dp[i][j] = dp[i][j] || dp[i - 1][j];
                    }
                } else {
                    // If p[j-1] is a regular character or '.'
                    // Check if s[i-1] matches p[j-1]
                    if (s[i - 1] == p[j - 1] || p[j - 1] == '.') {
                        // If they match, then the current state depends on the previous diagonal state
                        dp[i][j] = dp[i - 1][j - 1];
                    }
                }
            }
        }

        return dp[m][n];
    }
};