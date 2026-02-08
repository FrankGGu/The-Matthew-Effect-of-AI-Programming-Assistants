class Solution {
public:
    int maxSumDivThree(vector<int>& nums) {
        int dp[3] = {0, 0, 0};
        for (int num : nums) {
            int temp[3] = {dp[0], dp[1], dp[2]};
            for (int i = 0; i < 3; ++i) {
                dp[(i + num) % 3] = max(dp[(i + num) % 3], temp[i] + num);
            }
        }
        return dp[0];
    }
};