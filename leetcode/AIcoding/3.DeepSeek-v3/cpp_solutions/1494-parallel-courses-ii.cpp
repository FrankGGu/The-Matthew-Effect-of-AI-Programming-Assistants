class Solution {
public:
    int minNumberOfSemesters(int n, vector<vector<int>>& dependencies, int k) {
        vector<int> pre(n);
        for (auto& dep : dependencies) {
            int u = dep[0] - 1, v = dep[1] - 1;
            pre[v] |= 1 << u;
        }

        vector<int> dp(1 << n, n);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            if (dp[mask] == n) continue;

            int available = 0;
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i)) && (pre[i] & mask) == pre[i]) {
                    available |= 1 << i;
                }
            }

            for (int subset = available; subset; subset = (subset - 1) & available) {
                if (__builtin_popcount(subset) > k) continue;
                dp[mask | subset] = min(dp[mask | subset], dp[mask] + 1);
            }
        }

        return dp[(1 << n) - 1];
    }
};