#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    int solve(std::string s, int k) {
        int n = s.length();

        std::vector<int> pref_bal(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            pref_bal[i + 1] = pref_bal[i] + (s[i] == '1' ? 1 : -1);
        }

        const int NEG_INF = -1e9; 
        std::vector<std::vector<int>> dp(n + 1, std::vector<int>(k + 1, NEG_INF));

        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            dp[i][0] = 0; 

            for (int j = 1; j <= k; ++j) {
                dp[i][j] = dp[i-1][j];

                for (int p = 0; p < i; ++p) {
                    if (pref_bal[i] == pref_bal[p]) {
                        if (dp[p][j-1] != NEG_INF) {
                            dp[i][j] = std::max(dp[i][j], dp[p][j-1] + (i - p));
                        }
                    }
                }
            }
        }

        return dp[n][k] == NEG_INF ? -1 : dp[n][k];
    }
};