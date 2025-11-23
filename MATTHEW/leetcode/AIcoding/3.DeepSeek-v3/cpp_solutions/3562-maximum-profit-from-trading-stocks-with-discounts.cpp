class Solution {
public:
    int maxProfit(vector<int>& prices, vector<int>& discounts) {
        sort(prices.rbegin(), prices.rend());
        sort(discounts.rbegin(), discounts.rend());
        int profit = 0;
        int n = min(prices.size(), discounts.size());
        for (int i = 0; i < n; ++i) {
            profit += max(0, prices[i] - discounts[i]);
        }
        return profit;
    }
};