#include <vector>

class Solution {
public:
    int sumOfPower(std::vector<int>& nums, int k) {
        long long MOD = 1e9 + 7;
        std::vector<long long> dp(k + 1, 0);
        dp[0] = 1;

        for (int num : nums) {
            for (int j = k; j >= num; --j) {
                dp[j] = (dp[j] * 2 + dp[j - num]) % MOD;
            }
            for (int j = num - 1; j >= 0; --j) {
                dp[j] = (dp[j] * 2) % MOD;
            }
        }

        return static_cast<int>(dp[k]);
    }
};