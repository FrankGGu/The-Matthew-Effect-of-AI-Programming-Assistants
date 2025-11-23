class Solution {
public:
    int countSpecialPerms(int n) {
        vector<int> dp(1 << n, 0);
        dp[0] = 1;

        for (int mask = 0; mask < (1 << n); ++mask) {
            int x = __builtin_popcount(mask);
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i))) {
                    int nextMask = mask | (1 << i);
                    if (x == 0 || (i + 1) % (x + 1) == 0 || (x + 1) % (i + 1) == 0) {
                        dp[nextMask] = (dp[nextMask] + dp[mask]) % 1000000007;
                    }
                }
            }
        }
        return dp[(1 << n) - 1];
    }
};