class Solution {
public:
    int maxSalesDays(vector<int>& sales) {
        int n = sales.size();
        if (n == 0) return 0;

        vector<int> dp(n, 0);
        dp[0] = sales[0];
        int maxSales = dp[0];

        for (int i = 1; i < n; i++) {
            dp[i] = max(dp[i-1] + sales[i], sales[i]);
            maxSales = max(maxSales, dp[i]);
        }

        return maxSales;
    }
};