class Solution {
public:
    int findIntegers(int n) {
        vector<int> dp(32);
        dp[0] = 1;
        dp[1] = 2;
        for (int i = 2; i < 32; ++i) {
            dp[i] = dp[i - 1] + dp[i - 2];
        }

        int ans = 0, prev_bit = 0;
        for (int i = 31; i >= 0; --i) {
            if (n & (1 << i)) {
                ans += dp[i];
                if (prev_bit) {
                    return ans;
                }
                prev_bit = 1;
            } else {
                prev_bit = 0;
            }
        }

        return ans + 1;
    }
};