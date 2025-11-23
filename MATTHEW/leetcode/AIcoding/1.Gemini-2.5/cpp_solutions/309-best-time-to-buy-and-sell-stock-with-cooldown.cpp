#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int maxProfit(std::vector<int>& prices) {
        if (prices.empty()) {
            return 0;
        }

        int n = prices.size();

        int hold = -prices[0];
        int ready_to_buy = 0;
        int cooldown = std::numeric_limits<int>::min() / 2; 

        for (int i = 1; i < n; ++i) {
            int prev_hold = hold;
            int prev_ready_to_buy = ready_to_buy;
            int prev_cooldown = cooldown;

            hold = std::max(prev_hold, prev_ready_to_buy - prices[i]);
            ready_to_buy = std::max(prev_ready_to_buy, prev_cooldown);
            cooldown = prev_hold + prices[i];
        }

        return std::max(ready_to_buy, cooldown);
    }
};