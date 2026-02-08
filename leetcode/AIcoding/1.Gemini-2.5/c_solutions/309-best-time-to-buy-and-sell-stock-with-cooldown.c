#include <limits.h> // For INT_MIN

static int max(int a, int b) {
    return a > b ? a : b;
}

int maxProfit(int* prices, int pricesSize) {
    if (pricesSize <= 1) {
        return 0;
    }

    // s0: max profit if we are free to buy (not holding a stock, not in cooldown)
    // s1: max profit if we are holding a stock
    // s2: max profit if we are in cooldown (just sold a stock)

    // Initialize states for day 0
    // If we do nothing on day 0, profit is 0 and we are in s0 state.
    int s0 = 0;
    // If we buy on day 0, profit is -prices[0] and we are in s1 state.
    int s1 = -prices[0];
    // We cannot be in a cooldown state on day 0, so initialize to a very small number
    // to ensure it's not chosen as a valid path unless it's the only option,
    // or if a real profit path emerges.
    int s2 = INT_MIN;

    // Iterate through the rest of the days
    for (int i = 1; i < pricesSize; i++) {
        // Store previous day's states to calculate current day's states
        int prev_s0 = s0;
        int prev_s1 = s1;
        int prev_s2 = s2;

        // Calculate current day's s0 (free to buy)
        // Option 1: We were already in s0 state yesterday (did nothing or finished cooldown before).
        // Option 2: We were in s2 state yesterday (finished cooldown).
        s0 = max(prev_s0, prev_s2);

        // Calculate current day's s1 (holding a stock)
        // Option 1: We were already in s1 state yesterday (kept holding).
        // Option 2: We were in s0 state yesterday and bought today.
        s1 = max(prev_s1, prev_s0 - prices[i]);

        // Calculate current day's s2 (in cooldown)
        // We must have been in s1 state yesterday and sold today.
        // If prev_s1 was INT_MIN, it means we couldn't have held a stock to sell,
        // so prev_s1 + prices[i] will also be a very small negative number (no overflow).
        s2 = prev_s1 + prices[i];
    }

    // The maximum profit can be achieved if we end up either in s0 (not holding, not in cooldown)
    // or in s2 (just sold, in cooldown).
    // It cannot be s1, because s1 means we are still holding a stock, and profit is only realized upon selling.
    return max(s0, s2);
}