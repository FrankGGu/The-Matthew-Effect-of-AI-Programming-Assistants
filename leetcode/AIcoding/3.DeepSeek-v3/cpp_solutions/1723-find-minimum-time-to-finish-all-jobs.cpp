class Solution {
public:
    int minimumTimeRequired(vector<int>& jobs, int k) {
        int n = jobs.size();
        vector<int> sum(1 << n);
        for (int mask = 0; mask < (1 << n); ++mask) {
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    sum[mask] += jobs[i];
                }
            }
        }

        vector<vector<int>> dp(k, vector<int>(1 << n, INT_MAX));
        for (int mask = 0; mask < (1 << n); ++mask) {
            dp[0][mask] = sum[mask];
        }

        for (int i = 1; i < k; ++i) {
            for (int mask = 0; mask < (1 << n); ++mask) {
                for (int subset = mask; subset > 0; subset = (subset - 1) & mask) {
                    dp[i][mask] = min(dp[i][mask], max(dp[i-1][mask ^ subset], sum[subset]));
                }
            }
        }

        return dp[k-1][(1 << n) - 1];
    }
};