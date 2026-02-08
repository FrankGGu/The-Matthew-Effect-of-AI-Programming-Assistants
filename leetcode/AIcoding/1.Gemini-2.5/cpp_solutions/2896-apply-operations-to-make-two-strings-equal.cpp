#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    int minOperations(std::string s1, std::string s2, int x) {
        std::vector<int> diff;
        for (int i = 0; i < s1.length(); ++i) {
            if (s1[i] != s2[i]) {
                diff.push_back(i);
            }
        }

        int k = diff.size();
        if (k % 2 != 0) {
            return -1;
        }
        if (k == 0) {
            return 0;
        }

        std::vector<std::vector<int>> dp(k, std::vector<int>(k, 0));

        for (int len = 2; len <= k; len += 2) {
            for (int i = 0; i <= k - len; ++i) {
                int j = i + len - 1;

                int cost_pair_ij = std::min(x, diff[j] - diff[i]);
                int inner_cost = (len == 2) ? 0 : dp[i + 1][j - 1];
                int res = inner_cost + cost_pair_ij;

                for (int p = i + 1; p < j; p += 2) {
                    res = std::min(res, dp[i][p] + dp[p + 1][j]);
                }
                dp[i][j] = res;
            }
        }

        return dp[0][k - 1];
    }
};