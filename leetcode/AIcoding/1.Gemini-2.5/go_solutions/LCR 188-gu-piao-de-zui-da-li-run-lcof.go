package main

import "math"

func maxProfit(prices []int) int {
	if len(prices) == 0 {
		return 0
	}

	minPrice := math.MaxInt32
	maxProfit := 0

	for _, price := range prices {
		if price < minPrice {
			minPrice = price
		} else if price-minPrice > maxProfit {
			maxProfit = price - minPrice
		}
	}

	return maxProfit
}