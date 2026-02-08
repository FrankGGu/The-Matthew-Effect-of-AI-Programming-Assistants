class Solution {
public:
    int countPartitions(vector<int>& nums, int k) {
        const int MOD = 1e9 + 7;
        int n = nums.size();
        long long totalSum = accumulate(nums.begin(), nums.end(), 0LL);
        if (totalSum < k) return 0;

        vector<long long> dp(totalSum + 1, 0);
        dp[0] = 1;

        for (int num : nums) {
            for (int j = totalSum; j >= num; j--) {
                dp[j] = (dp[j] + dp[j - num]) % MOD;
            }
        }

        long long result = 0;
        for (int i = k; i <= totalSum; i++) {
            result = (result + dp[i]) % MOD;
        }

        return result;
    }
};