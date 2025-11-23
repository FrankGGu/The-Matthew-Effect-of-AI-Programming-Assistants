#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxTotalReward(vector<int>& reward, vector<int>& ops, int k) {
        int n = reward.size();
        vector<long long> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + reward[i - 1];
        }

        for (int i = 0; i < k; ++i) {
            vector<long long> next_dp(n + 1, 0);
            for (int j = 1; j <= n; ++j) {
                next_dp[j] = max(dp[j], next_dp[j - 1]);
                if (ops[j - 1] > 0) {
                    next_dp[j] = max(next_dp[j], dp[j - 1] + (long long)(reward[j - 1] / 2));
                }
            }
            dp = next_dp;
        }

        return dp[n];
    }
};