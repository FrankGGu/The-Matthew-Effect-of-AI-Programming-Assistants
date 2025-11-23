#include <vector>
#include <algorithm>

class Solution {
public:
    int maxProfit(std::vector<int>& prices, int fee) {
        if (prices.empty()) {
            return 0;
        }

        int n = prices.size();

        int cash = 0;
        int hold = -prices[0];

        for (int i = 1; i < n; ++i) {
            int prev_cash = cash;

            cash = std::max(cash, hold + prices[i] - fee);
            hold = std::max(hold, prev_cash - prices[i]);
        }

        return cash;
    }
};