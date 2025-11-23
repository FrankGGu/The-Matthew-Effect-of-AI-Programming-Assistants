class Solution {
public:
    int maximumSpending(vector<int>& prices, int budget) {
        sort(prices.begin(), prices.end());
        int spend = 0, count = 0;
        for (int price : prices) {
            if (spend + price <= budget) {
                spend += price;
                count++;
            } else {
                break;
            }
        }
        return spend;
    }
};