class Solution {
public:
    int countSubsets(vector<int>& nums, int limit) {
        int n = nums.size();
        vector<int> dp(limit + 1, 0);
        dp[0] = 1;

        for (int num : nums) {
            for (int j = limit; j >= num; --j) {
                dp[j] = (dp[j] + dp[j - num]) % 1000000007;
            }
        }

        long long result = 0;
        for (int i = 0; i <= limit; ++i) {
            result = (result + dp[i]) % 1000000007;
        }

        return result;
    }
};