#include <stdlib.h> // Required for max, though often implemented manually or with ternary in competitive programming

int maxProfit(int* prices, int pricesSize, int discount) {
    if (pricesSize <= 1) {
        return 0;
    }

    // dp_buy represents the maximum profit if we currently hold a stock.
    // dp_sell represents the maximum profit if we currently do not hold a stock.

    // Initialize for the first day (day 0)
    // If we buy on day 0: profit is -prices[0] (cost of buying) - discount (transaction fee).
    int dp_buy = -prices[0] - discount;

    // If we don't hold a stock on day 0: profit is 0.
    int dp_sell = 0;

    // Iterate through the rest of the days
    for (int i = 1; i < pricesSize; i++) {
        // Calculate the potential new dp_buy state:
        // 1. Keep holding the stock (no action today): dp_buy remains the same.
        // 2. Buy a stock today: We must have not held a stock yesterday (profit was dp_sell).
        //    So, dp_sell - prices[i] - discount.
        // We take the maximum of these two possibilities.
        int new_dp_buy = (dp_buy > dp_sell - prices[i] - discount) ? dp_buy : (dp_sell - prices[i] - discount);

        // Calculate the potential new dp_sell state:
        // 1. Keep not holding a stock (no action today): dp_sell remains the same.
        // 2. Sell a stock today: We must have held a stock yesterday (profit was dp_buy).
        //    So, dp_buy + prices[i]. (The discount/fee was already applied when buying).
        // We take the maximum of these two possibilities.
        int new_dp_sell = (dp_sell > dp_buy + prices[i]) ? dp_sell : (dp_buy + prices[i]);

        // Update the states for the current day
        dp_buy = new_dp_buy;
        dp_sell = new_dp_sell;
    }

    // The maximum profit will always be in dp_sell, as we want to end up without holding a stock
    // to realize all profits.
    return dp_sell;
}