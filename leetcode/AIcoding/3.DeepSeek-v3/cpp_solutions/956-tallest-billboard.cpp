class Solution {
public:
    int tallestBillboard(vector<int>& rods) {
        unordered_map<int, int> dp;
        dp[0] = 0;
        for (int x : rods) {
            unordered_map<int, int> cur(dp);
            for (auto it : dp) {
                int d = it.first;
                int val = it.second;
                cur[d + x] = max(cur[d + x], val);
                cur[abs(d - x)] = max(cur[abs(d - x)], val + min(d, x));
            }
            dp = cur;
        }
        return dp[0];
    }
};