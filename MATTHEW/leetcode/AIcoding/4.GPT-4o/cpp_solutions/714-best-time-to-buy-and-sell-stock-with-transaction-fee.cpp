class Solution {
public:
    int maxProfit(vector<int>& prices, int fee) {
        int n = prices.size();
        if (n == 0) return 0;

        vector<int> hold(n, 0), cash(n, 0);
        hold[0] = -prices[0] - fee;
        cash[0] = 0;

        for (int i = 1; i < n; i++) {
            hold[i] = max(hold[i - 1], cash[i - 1] - prices[i] - fee);
            cash[i] = max(cash[i - 1], hold[i - 1] + prices[i]);
        }

        return cash[n - 1];
    }
};