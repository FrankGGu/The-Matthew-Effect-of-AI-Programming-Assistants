#include <vector>
#include <algorithm>

class Solution {
public:
    int maxProfit(std::vector<int>& prices) {
        if (prices.empty()) {
            return 0;
        }

        int minPrice = prices[0];
        int maxProfitValue = 0;

        for (int i = 1; i < prices.size(); ++i) {
            minPrice = std::min(minPrice, prices[i]);
            maxProfitValue = std::max(maxProfitValue, prices[i] - minPrice);
        }

        return maxProfitValue;
    }
};