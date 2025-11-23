import "math"

func maxProfit(prices []int, fee int) int {
	if len(prices) == 0 {
		return 0
	}

	// cash: maximum profit if we don't have a stock.
	// hold: maximum profit if we have a stock.
	// Initialize cash to