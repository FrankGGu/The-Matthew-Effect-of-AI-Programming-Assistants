class Solution {
public:
    bool splitArraySameAverage(vector<int>& nums) {
        int n = nums.size();
        if (n == 1) return false;
        int totalSum = accumulate(nums.begin(), nums.end(), 0);
        vector<vector<bool>> dp(totalSum + 1, vector<bool>(n / 2 + 1, false));
        dp[0][0] = true;

        for (int num : nums) {
            for (int sum = totalSum; sum >= num; --sum) {
                for (int k = 1; k <= n / 2; ++k) {
                    if (dp[sum - num][k - 1]) {
                        dp[sum][k] = true;
                    }
                }
            }
        }

        for (int k = 1; k <= n / 2; ++k) {
            if (totalSum * k % n == 0) {
                int targetSum = totalSum * k / n;
                if (targetSum <= totalSum && dp[targetSum][k]) {
                    return true;
                }
            }
        }

        return false;
    }
};