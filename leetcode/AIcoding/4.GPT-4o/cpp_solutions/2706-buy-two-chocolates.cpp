class Solution {
public:
    int buyChoco(vector<int>& prices, int money) {
        sort(prices.begin(), prices.end());
        if (prices.size() < 2) return money; // Not enough chocolates to buy two
        int totalCost = prices[0] + prices[1];
        return money >= totalCost ? money - totalCost : money;
    }
};