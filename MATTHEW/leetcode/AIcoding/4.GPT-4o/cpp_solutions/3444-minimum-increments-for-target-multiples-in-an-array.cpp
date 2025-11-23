class Solution {
public:
    int minIncrements(int n, vector<int>& cost) {
        vector<long long> dp(n + 1, 0);
        long long totalCost = 0;

        for (int i = n - 1; i >= 0; --i) {
            dp[i] = cost[i] + dp[2 * i + 1] + dp[2 * i + 2];
            totalCost += dp[i];
        }

        return totalCost;
    }
};