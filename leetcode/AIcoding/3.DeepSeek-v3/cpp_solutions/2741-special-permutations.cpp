class Solution {
public:
    int specialPerm(vector<int>& nums) {
        int n = nums.size();
        int total = 1 << n;
        vector<vector<int>> dp(total, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) {
            dp[1 << i][i] = 1;
        }
        for (int mask = 0; mask < total; ++mask) {
            for (int last = 0; last < n; ++last) {
                if (!(mask & (1 << last))) continue;
                for (int next = 0; next < n; ++next) {
                    if (mask & (1 << next)) continue;
                    if (nums[last] % nums[next] == 0 || nums[next] % nums[last] == 0) {
                        dp[mask | (1 << next)][next] += dp[mask][last];
                    }
                }
            }
        }
        int res = 0;
        for (int i = 0; i < n; ++i) {
            res += dp[total - 1][i];
        }
        return res;
    }
};