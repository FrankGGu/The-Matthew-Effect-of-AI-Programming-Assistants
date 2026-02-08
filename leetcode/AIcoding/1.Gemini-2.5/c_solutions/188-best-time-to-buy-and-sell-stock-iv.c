#include <stdlib.h> // For malloc, free, calloc
#include <math.h>   // For fmax
#include <limits.h> // For INT_MIN

int maxProfit(int k, int* prices, int pricesSize) {
    if (pricesSize == 0 || k == 0) {
        return 0;
    }

    int n = pricesSize;

    // Optimization: If k is large enough, it's equivalent to unlimited transactions.
    // A transaction involves a buy and a sell, requiring at least 2 days to make a profit.
    // Thus, the maximum number of distinct transactions is n/2.
    // If k >= n/2, we can make as many transactions as possible.
    if (k >= n / 2) {
        int max_profit = 0;
        for (int i = 1; i < n; i++) {
            if (prices[i] > prices[i-1]) {
                max_profit += prices[i] - prices[i-1];
            }
        }
        return max_profit;
    }

    // DP approach for limited k
    // dp[t][d] = maximum profit with at most t transactions up to day d.
    // We use space optimization by only keeping track of the previous transaction's row.
    // prev_dp[d] stores dp[t-1][d]
    // current_dp[d] stores dp[t][d]
    int* prev_dp = (int*)calloc(n, sizeof(int));    // Stores profits for t-1 transactions
    int* current_dp = (int*)calloc(n, sizeof(int)); // Stores profits for t transactions

    // Loop for transactions (from 1 to k)
    for (int t = 1; t <= k; t++) {
        // max_profit_before_buy tracks max(prev_dp[j] - prices[j]) for j < current_day.
        // This represents the maximum profit obtained with t-1 transactions up to day j,
        // minus the price of buying on day j.
        // Initialize for day 0: we can "buy" on day 0. Profit before buying is prev_dp[0] (which is 0).
        // So, max_profit_before_buy starts as 0 - prices[0] = -prices[0].
        int max_profit_before_buy = -prices[0];

        // Loop for days (from 1 to n-1)
        for (int d = 1; d < n; d++) {
            // Option 1: Do not make a transaction (sell) on day 'd'.
            // The profit is the same as the maximum profit up to the previous day 'd-1' with 't' transactions.
            current_dp[d] = current_dp[d-1];

            // Option 2: Make a transaction (sell) on day 'd'.
            // The profit is prices[d] + max_profit_before_buy.
            // max_profit_before_buy already holds the maximum (profit_with_t-1_transactions_before_buy_day - price_on_buy_day)
            current_dp[d] = fmax(current_dp[d], prices[d] + max_profit_before_buy);

            // Update max_profit_before_buy for the next day (d+1).
            // This means considering buying on day 'd' for a future transaction.
            // The profit before this potential buy on day 'd' would be prev_dp[d].
            // So, a candidate for max_profit_before_buy is prev_dp[d] - prices[d].
            max_profit_before_buy = fmax(max_profit_before_buy, prev_dp[d] - prices[d]);
        }

        // After completing calculations for transaction 't',
        // current_dp becomes prev_dp for the next transaction 't+1'.
        for (int i = 0; i < n; i++) {
            prev_dp[i] = current_dp[i];
        }
    }

    int result = current_dp[n-1];

    // Free allocated memory
    free(prev_dp);
    free(current_dp);

    return result;
}