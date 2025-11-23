package main

import "math"

func maxProfit(prices []int, fee int) int {
	cash := 0
	hold := -prices[0]

	for i := 1; i < len(prices); i++ {
		prevCash := cash
		cash = int(math.Max(float64(cash), float64(hold+prices[i]-fee)))
		hold = int(math.Max(float64(hold), float64(prevCash-prices[i])))
	}

	return cash
}