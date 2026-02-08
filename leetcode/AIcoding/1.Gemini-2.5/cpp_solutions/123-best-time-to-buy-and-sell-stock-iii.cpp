#include <vector>
#include <algorithm> // For std::max
#include <limits>    // For std::numeric_limits

class Solution {
public:
    int maxProfit(std::vector<int>& prices) {
        if (prices.empty()) {
            return 0;
        }

        // buy1_profit: maximum profit after completing the first 'buy' operation.
        //              This is effectively -cost_of_first_buy. We want to maximize this (minimize cost).
        // sell1_profit: maximum profit after completing the first 'sell' operation.
        // buy2_profit: maximum profit after completing the second 'buy' operation.
        //              This is effectively sell1_profit - cost_of_second_buy.
        // sell2_profit: maximum profit after completing the second 'sell' operation.

        // Initialize 'buy' states to the smallest possible integer value (representing a very large loss
        // or no transaction yet, ensuring any actual buy will result in a higher profit).
        // Initialize 'sell' states to 0 (representing no profit yet).
        int buy1_profit = std::numeric_limits<int>::min();
        int sell1_profit = 0;
        int buy2_profit = std::numeric_limits<int>::min();
        int sell2_profit = 0;

        for (int price : prices) {
            // Update sell2_profit:
            // Either retain the current max sell2_profit, or achieve a new one by selling the second stock
            // (which implies we had buy2_profit and now add current price).
            sell2_profit = std::max(sell2_profit, buy2_profit + price);

            // Update buy2_profit:
            // Either retain the current max buy2_profit, or achieve a new one by buying the second stock
            // (which implies we had sell1_profit and now subtract current price to buy).
            buy2_profit = std::max(buy2_profit, sell1_profit - price);

            // Update sell1_profit:
            // Either retain the current max sell1_profit, or achieve a new one by selling the first stock
            // (which implies we had buy1_profit and now add current price).
            sell1_profit = std::max(sell1_profit, buy1_profit + price);

            // Update buy1_profit:
            // Either retain the current max buy1_profit, or achieve a new one by buying the first stock
            // (which implies we just incur the cost of current price).
            buy1_profit = std::max(buy1_profit, -price);
        }

        // The maximum profit after at most two transactions will be stored in sell2_profit.
        return sell2_profit;
    }
};