#include <limits.h> // Required for INT_MIN

#ifndef max
#define max(a,b) ((a) > (b) ? (a) : (b))
#endif

#ifndef min
#define min(a,b) ((a) < (b) ? (a) : (b))
#endif

int maxProfit(int* prices, int pricesSize) {
    if (pricesSize == 0) {
        return 0;
    }

    // buy1: Represents the maximum profit after completing the first 'buy' transaction.
    //       Since buying reduces capital, this value will be negative (or INT_MIN if no buy yet).
    //       It's effectively -cost_of_first_buy.
    // sell1: Represents the maximum profit after completing the first 'sell' transaction.
    //        This is the profit from one complete transaction.
    // buy2: Represents the maximum profit after completing the second 'buy' transaction.
    //       This value is (profit_from_first_transaction - cost_of_second_buy).
    // sell2: Represents the maximum profit after completing the second 'sell' transaction.
    //        This is the total profit from two complete transactions.

    // Initialize buy states to INT_MIN to signify an unachievable (infinitely expensive) buy.
    // Initialize sell states to 0, as no profit has been made yet.
    int buy1 = INT_MIN;
    int sell1 = 0;
    int buy2 = INT_MIN;
    int sell2 = 0;

    for (int i = 0; i < pricesSize; i++) {
        // Update states in reverse order to ensure that when a state depends on a previous
        // state (e.g., buy2 depends on sell1), it uses the value from the previous day's
        // state or a state that has already been correctly updated for the current day
        // without creating dependencies on "future" updates within the same iteration.

        // sell2: Maximum profit after selling the second stock.
        // It's either the previous max sell2, or the profit from buying the second stock (buy2)
        // plus the current price (prices[i]) if we sell it today.
        sell2 = max(sell2, buy2 + prices[i]);

        // buy2: Maximum profit after buying the second stock.
        // It's either the previous max buy2, or the profit from selling the first stock (sell1)
        // minus the current price (prices[i]) if we buy it today.
        buy2 = max(buy2, sell1 - prices[i]);

        // sell1: Maximum profit after selling the first stock.
        // It's either the previous max sell1, or the profit from buying the first stock (buy1)
        // plus the current price (prices[i]) if we sell it today.
        sell1 = max(sell1, buy1 + prices[i]);

        // buy1: Maximum profit after buying the first stock.
        // It's either the previous max buy1, or the negative of the current price (prices[i])
        // if we buy it today.
        buy1 = max(buy1, -prices[i]);
    }

    // The maximum profit after at most two transactions is stored in sell2.
    return sell2;
}