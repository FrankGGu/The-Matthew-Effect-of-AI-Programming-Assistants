class Solution {
public:
    int minimumCost(string s) {
        int n = s.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            int cost = 0;
            for (int j = i; j >= 1; --j) {
                cost += s[j - 1] - 'a' + 1;
                dp[i] = min(dp[i], dp[j - 1] + cost);
            }
        }

        return dp[n];
    }
};