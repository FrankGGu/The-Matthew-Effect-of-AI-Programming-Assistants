class Solution {
public:
    int maximumLength(vector<int>& nums, int k) {
        unordered_map<int, vector<int>> dp;
        vector<int> max_dp(k + 2, 0);
        int res = 0;

        for (int num : nums) {
            if (dp.find(num) == dp.end()) {
                dp[num] = vector<int>(k + 1, 0);
            }
            vector<int>& curr = dp[num];
            for (int j = k; j >= 0; --j) {
                curr[j] = max(curr[j], (j > 0 ? max_dp[j - 1] : 0)) + 1;
                max_dp[j] = max(max_dp[j], curr[j]);
                res = max(res, curr[j]);
            }
        }

        return res;
    }
};