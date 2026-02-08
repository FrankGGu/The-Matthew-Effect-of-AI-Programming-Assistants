package main

import "math"

func maxProfit(prices []int) int {
	n := len(prices)
	if n == 0 {
		return 0
	}

	// b1: max profit if we've bought the first stock (and are currently holding it)
	// s1: max profit if we've sold the first stock (and are not holding any)
	// b2: max profit if we've bought the second stock (and are currently holding it)
	// s2: max profit if we've sold the second stock (and are not holding any)

	// Initialize with a very small number for buy states to ensure any valid buy is better
	// and 0 for sell states as initial profit is 0
	b1 := math.MinInt32
	s1 := 0
	b2 := math.MinInt32
	s2 := 0

	for _, price := range prices {
		// Update s2: max profit after selling the second stock
		// Either keep previous s2, or sell the second stock today (b2 + price)
		s2 = max(s2, b2+price)

		// Update b2: max profit after buying the second stock
		// Either keep previous b2, or buy the second stock today (s1 - price)
		b2 = max(b2, s1-price)

		// Update s1: max profit after selling the first stock
		// Either keep previous s1, or sell the first stock today (b1 + price)
		s1 = max(s1, b1+price)

		// Update b1: max profit after buying the first stock
		// Either keep previous b1, or buy the first stock today (-price)
		b1 = max(b1, -price)
	}

	return s2
}

func max(a, b int) bool {
	if a > b {
		return a
	}
	return b
}