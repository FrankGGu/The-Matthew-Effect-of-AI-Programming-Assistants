class Solution {
public:
    int numberWays(vector<vector<int>>& hats) {
        const int MOD = 1e9 + 7;
        int n = hats.size();
        vector<vector<int>> persons(41);
        for (int i = 0; i < n; ++i) {
            for (int h : hats[i]) {
                persons[h].push_back(i);
            }
        }

        vector<int> dp(1 << n);
        dp[0] = 1;

        for (int h = 1; h <= 40; ++h) {
            vector<int> new_dp = dp;
            for (int mask = 0; mask < (1 << n); ++mask) {
                for (int p : persons[h]) {
                    if (!(mask & (1 << p))) {
                        int new_mask = mask | (1 << p);
                        new_dp[new_mask] = (new_dp[new_mask] + dp[mask]) % MOD;
                    }
                }
            }
            dp = move(new_dp);
        }

        return dp[(1 << n) - 1];
    }
};