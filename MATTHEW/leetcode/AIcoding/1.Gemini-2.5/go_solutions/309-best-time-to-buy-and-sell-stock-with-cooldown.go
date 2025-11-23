import "math"

func maxProfit(prices []int) int {
	n := len(prices)
	if n <= 1 {
		return 0
	}

	// buy[i]: max profit if we end up holding a stock on day i
	// sell[i]: max profit if we end up not holding a stock on