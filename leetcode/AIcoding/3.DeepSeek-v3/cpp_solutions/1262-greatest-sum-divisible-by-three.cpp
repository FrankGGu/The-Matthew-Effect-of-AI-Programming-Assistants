class Solution {
public:
    int maxSumDivThree(vector<int>& nums) {
        vector<int> dp = {0, INT_MIN, INT_MIN};
        for (int num : nums) {
            vector<int> next_dp = dp;
            for (int i = 0; i < 3; ++i) {
                int sum = dp[i] + num;
                int rem = sum % 3;
                next_dp[rem] = max(next_dp[rem], sum);
            }
            dp = next_dp;
        }
        return dp[0];
    }
};