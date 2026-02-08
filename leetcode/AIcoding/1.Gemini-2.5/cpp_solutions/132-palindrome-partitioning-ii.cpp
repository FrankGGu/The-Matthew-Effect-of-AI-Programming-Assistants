#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minCut(std::string s) {
        int n = s.length();
        if (n <= 1) {
            return 0;
        }

        std::vector<int> dp(n);
        for (int i = 0; i < n; ++i) {
            dp[i] = i;
        }

        for (int i = 0; i < n; ++i) {
            // Odd length palindromes
            for (int l = i, r = i; l >= 0 && r < n && s[l] == s[r]; --l, ++r) {
                int new_cuts = (l == 0) ? 0 : dp[l - 1] + 1;
                dp[r] = std::min(dp[r], new_cuts);
            }

            // Even length palindromes
            for (int l = i, r = i + 1; l >= 0 && r < n && s[l] == s[r]; --l, ++r) {
                int new_cuts = (l == 0) ? 0 : dp[l - 1] + 1;
                dp[r] = std::min(dp[r], new_cuts);
            }
        }

        return dp[n - 1];
    }
};