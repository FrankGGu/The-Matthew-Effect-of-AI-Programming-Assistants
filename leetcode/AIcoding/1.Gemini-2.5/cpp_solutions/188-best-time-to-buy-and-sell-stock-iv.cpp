#include <vector>
#include <algorithm>
#include <climits> // For INT_MIN

class Solution {
public:
    int maxProfit(int k, std::vector<int>& prices) {
        int n = prices.size();

        if (n == 0 || k == 0) {
            return 0;
        }

        // If k is very large, it means we can make as many transactions as we want.
        // This reduces to "Best Time to Buy and Sell Stock II".
        // The maximum number of distinct buy/sell pairs (transactions) we can possibly make
        // is n/2 (e.g., buy on day 0, sell on day 1, buy on day 2, sell on day 3, etc.).
        // If k is greater than or equal to n/2, we can effectively perform unlimited transactions.
        if (k >= n / 2) {
            int maxProfit = 0;
            for (int i = 1; i < n; ++i) {
                if (prices[i] > prices[i-1]) {
                    maxProfit += prices[i] - prices[i-1];
                }
            }
            return maxProfit;
        }

        // DP approach for limited transactions
        // buy[j] represents the maximum profit ending with buying a stock,
        // having completed j-1 transactions and starting the j-th transaction.
        // sell[j] represents the maximum profit ending with selling a stock,
        // having completed j transactions.
        std::vector<int> buy(k + 1, INT_MIN);
        std::vector<int> sell(k + 1, 0);

        for (int price : prices) {
            // Iterate from k down to 1 to ensure that when we update buy[j] or sell[j],
            // we are using values from the previous day's state for j-1 or j transactions.
            // If we iterate upwards, sell[j-1] would already be updated with the current day's price,
            // which would be incorrect for buy[j].
            for (int j = k; j >= 1; --j) {
                // To achieve max profit with j completed transactions (not holding stock):
                // Option 1: We already had j completed transactions (and not holding stock) from the previous day (sell[j]).
                // Option 2: We had j-1 completed transactions, bought the j-th stock previously (buy[j]), and sell it today (+ price).
                sell[j] = std::max(sell[j], buy[j] + price);

                // To achieve max profit with j-1 completed transactions and buying the j-th stock today (holding stock):
                // Option 1: We already had j-1 completed transactions and bought the j-th stock previously (buy[j]).
                // Option 2: We had j-1 completed transactions (and not holding stock) from the previous day (sell[j-1]), and buy the j-th stock today (- price).
                buy[j] = std::max(buy[j], sell[j-1] - price);
            }
        }

        // The maximum profit will be in sell[k], as we want to end with no stock and k completed transactions.
        return sell[k];
    }
};