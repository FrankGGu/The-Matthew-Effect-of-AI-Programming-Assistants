#include <vector>
#include <algorithm>

class Solution {
public:
    long long minimumTime(std::vector<int>& strength) {
        int n = strength.size();

        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return strength[0];
        }
        if (n == 2) {
            return std::min((long long)strength[0], (long long)strength[1]);
        }

        std::vector<long long> dp(n);

        dp[0] = strength[0];
        dp[1] = std::min((long long)strength[0], (long long)strength[1]);

        dp[2] = std::min(dp[0] + strength[2], (long long)strength[1]);

        for (int i = 3; i < n; ++i) {
            long long cost_break_current_lock = dp[i-2] + strength[i];
            long long cost_break_prev_lock = dp[i-3] + strength[i-1];

            dp[i] = std::min(cost_break_current_lock, cost_break_prev_lock);
        }

        return dp[n-1];
    }
};