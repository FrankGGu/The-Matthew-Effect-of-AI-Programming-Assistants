class Solution {
public:
    int findIntegers(int n) {
        vector<int> dp(32, 0);
        dp[0] = 1;
        dp[1] = 2;
        for (int i = 2; i < 32; ++i) {
            dp[i] = dp[i-1] + dp[i-2];
        }
        int res = 0;
        int prev_bit = 0;
        for (int k = 30; k >= 0; --k) {
            if (n & (1 << k)) {
                res += dp[k];
                if (prev_bit == 1) {
                    return res;
                }
                prev_bit = 1;
            } else {
                prev_bit = 0;
            }
        }
        return res + 1;
    }
};