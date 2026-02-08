class Solution {
public:
    int countSpecialSubsequences(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        long long dp0 = 0, dp1 = 0, dp2 = 0;
        for (int num : nums) {
            if (num == 0) {
                dp0 = (2 * dp0 + 1) % MOD;
            } else if (num == 1) {
                dp1 = (2 * dp1 + dp0) % MOD;
            } else if (num == 2) {
                dp2 = (2 * dp2 + dp1) % MOD;
            }
        }
        return dp2;
    }
};