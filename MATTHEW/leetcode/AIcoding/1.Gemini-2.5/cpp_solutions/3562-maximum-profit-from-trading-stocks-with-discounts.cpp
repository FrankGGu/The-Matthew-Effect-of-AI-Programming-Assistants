#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    int maxProfit(std::vector<int>& prices, std::vector<int>& discounts) {
        if (prices.empty()) {
            return 0;
        }

        // buy_state: maximum profit if we end the current day holding a stock
        // sell_state: maximum profit if we end the current day not holding a stock

        // Initialize for day 0
        // If we buy on day 0, the cost is prices[0] - discounts[0].
        // So, the profit is -(prices[0] - discounts[0]).
        long long buy_state = -(long long)prices[0] + discounts[0];

        // If we don't hold a stock on day 0, the profit is 0.
        long long sell_state = 0;

        for (int i = 1; i < prices.size(); ++i) {
            // Calculate the maximum profit if we end day i holding a stock:
            // 1. We were already holding a stock from day i-1 (buy_state).
            // 2. We did not hold a stock on day i-1, and we bought one today.
            //    The profit from previous transactions (sell_state) minus the discounted cost of buying today.
            //    Cost of buying today: prices[i] - discounts[i].
            long long new_buy_state = std::max(buy_state, sell_state - (long long)prices[i] + discounts[i]);

            // Calculate the maximum profit if we end day i not holding a stock:
            // 1. We were already not holding a stock from day i-1 (sell_state).
            // 2. We were holding a stock on day i-1, and we sold it today.
            //    The profit from holding the stock (buy_state) plus the selling price today.
            long long new_sell_state = std::max(sell_state, buy_state + prices[i]);

            buy_state = new_buy_state;
            sell_state = new_sell_state;
        }

        // The maximum profit must be achieved when not holding any stock at the end of the last day.
        return static_cast<int>(sell_state);
    }
};