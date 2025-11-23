class Solution {
public:
    int countPartitions(vector<int>& nums, int k) {
        int n = nums.size();
        int totalSum = accumulate(nums.begin(), nums.end(), 0);
        if (totalSum < k || (totalSum - k) % 2 != 0) return 0;

        int target = (totalSum - k) / 2;
        vector<int> dp(target + 1, 0);
        dp[0] = 1;

        for (int num : nums) {
            for (int j = target; j >= num; j--) {
                dp[j] = (dp[j] + dp[j - num]) % 1000000007;
            }
        }

        return dp[target];
    }
};