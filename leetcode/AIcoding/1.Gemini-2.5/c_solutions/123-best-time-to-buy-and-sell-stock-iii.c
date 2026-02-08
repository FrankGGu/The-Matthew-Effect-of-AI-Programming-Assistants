#include <limits.h> // Required for INT_MIN

int maxProfit(int* prices, int pricesSize) {
    if (pricesSize == 0) {
        return 0;
    }

    // hold1: maximum profit if we are holding a stock after the first buy.
    //        (This value will be negative or zero, representing the cost incurred)
    // sold1: maximum profit if we have completed the first transaction (bought and sold).
    // hold2: maximum profit if we are holding a stock after the second buy.
    //        (This value will be profit from first transaction minus cost of second buy)
    // sold2: maximum profit if we have completed the second transaction.

    // Initialize hold states to INT_MIN to ensure that any actual buy operation
    // (which results in a negative profit or a profit less than INT_MIN but still valid)
    // will be preferred over not having bought.
    // Initialize sold states to 0 as no profit has been made yet.
    int hold1 = INT_MIN;
    int sold1 = 0;
    int hold2 = INT_MIN;
    int sold2 = 0;

    for (int i = 0; i < pricesSize; i++) {
        int current_price = prices[i];

        // Update sold2:
        // Option 1: Do nothing (keep previous sold2 profit).
        // Option 2: Sell today (current_price + profit from holding after second buy).
        sold2 = (sold2 > hold2 + current_price) ? sold2 : (hold2 + current_price);

        // Update hold2:
        // Option 1: Do nothing (keep previous hold2 profit).
        // Option 2: Buy today (profit from first sell - current_price).
        hold2 = (hold2 > sold1 - current_price) ? hold2 : (sold1 - current_price);

        // Update sold1:
        // Option 1: Do nothing (keep previous sold1 profit).
        // Option 2: Sell today (current_price + profit from holding after first buy).
        sold1 = (sold1 > hold1 + current_price) ? sold1 : (hold1 + current_price);

        // Update hold1:
        // Option 1: Do nothing (keep previous hold1 profit).
        // Option 2: Buy today (0 profit - current_price).
        hold1 = (hold1 > -current_price) ? hold1 : (-current_price);
    }

    // The maximum profit after at most two transactions will be in sold2.
    return sold2;
}