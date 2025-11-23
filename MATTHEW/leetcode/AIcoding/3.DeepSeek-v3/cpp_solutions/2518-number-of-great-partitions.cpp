class Solution {
public:
    int countPartitions(vector<int>& nums, int k) {
        long long total = accumulate(nums.begin(), nums.end(), 0LL);
        if (total < 2 * k) return 0;

        int n = nums.size();
        const int MOD = 1e9 + 7;
        vector<int> dp(k, 0);
        dp[0] = 1;

        for (int num : nums) {
            for (int j = k - 1; j >= num; --j) {
                dp[j] = (dp[j] + dp[j - num]) % MOD;
            }
        }

        int sum = 0;
        for (int j = 0; j < k; ++j) {
            sum = (sum + dp[j]) % MOD;
        }

        int totalPartitions = 1;
        for (int i = 0; i < n; ++i) {
            totalPartitions = (totalPartitions * 2) % MOD;
        }

        int result = (totalPartitions - 2LL * sum % MOD + MOD) % MOD;
        return result;
    }
};