class Solution {
public:
    int maxEnergy(vector<int>& energy) {
        int n = energy.size();
        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1];
            if (i >= 2) {
                dp[i] = max(dp[i], dp[i - 2] + energy[i - 1]);
            }
            if (i >= 3) {
                dp[i] = max(dp[i], dp[i - 3] + energy[i - 1]);
            }
        }
        return dp[n];
    }
};