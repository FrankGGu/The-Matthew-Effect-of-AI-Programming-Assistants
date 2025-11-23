class Solution {
public:
    int maximizeTheProfit(int n, vector<vector<int>>& offers) {
        vector<int> dp(n + 1, 0);
        sort(offers.begin(), offers.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        for (const auto& offer : offers) {
            int start = offer[0], end = offer[1], profit = offer[2];
            for (int i = end; i >= start; --i) {
                dp[i] = max(dp[i], dp[start] + profit);
            }
        }

        return dp[n];
    }
};