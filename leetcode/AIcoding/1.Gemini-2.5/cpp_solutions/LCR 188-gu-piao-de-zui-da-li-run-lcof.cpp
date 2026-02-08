#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int maxProfit(std::vector<int>& prices) {
        if (prices.empty()) {
            return 0;
        }

        int min_price = std::numeric_limits<int>::max();
        int max_profit = 0;

        for (int price : prices) {
            min_price = std::min(min_price, price);
            max_profit = std::max(max_profit, price - min_price);
        }

        return max_profit;
    }
};