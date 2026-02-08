class Solution {
public:
    int countPartitions(vector<int>& nums) {
        int n = nums.size();
        int totalSum = accumulate(nums.begin(), nums.end(), 0);
        if (totalSum % 2 != 0) {
            return 0;
        }
        int target = totalSum / 2;
        vector<int> dp(target + 1, 0);
        dp[0] = 1;
        for (int num : nums) {
            for (int j = target; j >= num; --j) {
                dp[j] = (dp[j] + dp[j - num]) % 1000000007;
            }
        }
        return dp[target];
    }
};