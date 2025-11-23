class Solution {
public:
    int tallestBillboard(vector<int>& rods) {
        unordered_map<int, int> dp;
        dp[0] = 0;
        for (int rod : rods) {
            unordered_map<int, int> temp = dp;
            for (auto& [diff, height] : temp) {
                dp[diff + rod] = max(dp[diff + rod], height);
                dp[diff - rod] = max(dp[diff - rod], height + (diff >= rod ? 0 : height));
                dp[diff] = max(dp[diff], height);
            }
        }
        return dp[0];
    }
};