package main

import (
	"math"
)

func maxProfit(k int, prices []int) int {
	n := len(prices)

	if n == 0 || k == 0 {
		return 0
	}

	// If k is large enough, it's equivalent to Best Time to Buy and Sell Stock II.
	// This means we can make a transaction every time the price increases.
	// The maximum number of transactions possible is n/2 (buy on day i, sell on day i+1).
	// If k is greater than or equal to this, we can capture all possible profits.
	if k >= n/2 {
		maxProf := 0
		for i := 1; i < n; i++ {
			if prices[i] > prices[i-1] {
				maxProf += prices[i] - prices[i-1]
			}
		}
		return maxProf
	}

	// dp[j][0] represents the maximum profit after j transactions, not holding a stock.
	// dp[j][1] represents the maximum profit after j transactions, holding a stock.
	// We use two arrays, 'buy' and 'sell', to store these states for space optimization.
	// 'buy[j]' stores the maximum profit after completing j-1 transactions and then buying the j-th stock.
	// 'sell[j]' stores the maximum profit after completing j transactions (i.e., selling the j-th stock).

	buy := make([]int, k+1)
	sell := make([]int, k+1)

	// Initialize 'buy' array with a very small number (negative infinity)
	// because initially, we have no profit and are holding no stock.
	// If we buy, our profit becomes negative.
	for j := 0; j <= k; j++ {
		buy[j] = math.MinInt32 // Represents negative infinity
		sell[j] = 0            // Initial profit with 0 transactions is 0
	}

	// Iterate through each price
	for _, price := range prices {
		// Iterate for each transaction count from k down to 1.
		// We iterate downwards to ensure that when we calculate buy[j] and sell[j],
		// sell[j-1] and buy[j] (from the *previous* day's calculations) are used.
		// If we iterate upwards, sell[j-1] would be from the *current* day's calculations,
		// which is incorrect for the definition of DP states.
		for j := k; j >= 1; j-- {
			// Calculate max profit for selling the j-th stock:
			// Option 1: Do nothing (keep previous 'sell[j]' state).
			// Option 2: Sell the stock today (current price + profit from having bought the j-th stock).
			sell[j] = max(sell[j], buy[j]+price)

			// Calculate max profit for buying the j-th stock:
			// Option 1: Do nothing (keep previous 'buy[j]' state).
			// Option 2: Buy the stock today (profit from having completed j-1 transactions - current price).
			buy[j] = max(buy[j], sell[j-1]-price)
		}
	}

	// The maximum profit will be after k transactions, not holding a stock.
	return sell[k]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}