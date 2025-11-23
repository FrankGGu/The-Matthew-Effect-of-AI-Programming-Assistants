#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumChanges(std::string s, int k) {
        int n = s.length();

        std::vector<std::vector<int>> costs(n, std::vector<int>(n));
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int current_cost = 0;
                int len = j - i + 1;
                for (int p = 0; p < len / 2; ++p) {
                    if (p % 2 == 0) {
                        if (s[i + p] != s[j - p]) {
                            current_cost++;
                        }
                    }
                }
                costs[i][j] = current_cost;
            }
        }

        std::vector<std::vector<int>> dp(k + 1, std::vector<int>(n + 1, 1e9));

        dp[0][0] = 0;

        for (int j = 1; j <= k; ++j) {
            for (int i = 1; i <= n; ++i) {
                for (int p = 0; p < i; ++p) { 
                    if (dp[j - 1][p] != 1e9) {
                        int cost_last_segment = costs[p][i - 1];
                        dp[j][i] = std::min(dp[j][i], dp[j - 1][p] + cost_last_segment);
                    }
                }
            }
        }

        return dp[k][n];
    }
};