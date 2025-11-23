class Solution {
public:
    int minSessions(vector<int>& tasks, int sessionTime) {
        int n = tasks.size();
        vector<int> dp(1 << n, INT_MAX / 2);
        dp[0] = 0;
        for (int mask = 1; mask < (1 << n); ++mask) {
            int time = 0;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    time += tasks[i];
                }
            }
            if (time <= sessionTime) {
                dp[mask] = 1;
                continue;
            }
            for (int subset = mask; subset > 0; subset = (subset - 1) & mask) {
                int other = mask ^ subset;
                if (dp[subset] + dp[other] < dp[mask]) {
                    dp[mask] = dp[subset] + dp[other];
                }
            }
        }
        return dp[(1 << n) - 1];
    }
};