class Solution {
public:
    int maximumReward(int n, vector<int>& operations) {
        vector<int> dp(n + 1, 0);
        for (int op : operations) {
            for (int i = n; i >= op; --i) {
                dp[i] = max(dp[i], dp[i - op] + op);
            }
        }
        return dp[n];
    }
};