class Solution {
public:
    int minimumTime(vector<int>& tasks) {
        int n = tasks.size();
        vector<int> dp(1 << n, INT_MAX);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            int completed = __builtin_popcount(mask);
            for (int j = 0; j < n; ++j) {
                if (!(mask & (1 << j))) {
                    int newMask = mask | (1 << j);
                    dp[newMask] = min(dp[newMask], dp[mask] + (completed + 1) * tasks[j]);
                }
            }
        }

        return dp[(1 << n) - 1];
    }
};