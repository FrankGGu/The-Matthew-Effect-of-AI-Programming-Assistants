import "math"

func maxProfit(prices []int) int {
	n := len(prices)
	if n == 0 {
		return 0
	}
	buy1 := -math.MaxInt32
	sell1 := 0
	buy2 := -math.MaxInt32
	sell2 := 0
	for i := 0; i < n; i++ {
		buy1 = max(buy1, -prices[i])
		sell1 = max(sell1, buy1+prices[i])
		buy2 = max(buy2, sell1-prices[i])
		sell2 = max(sell2, buy2+prices[i])
	}
	return sell2
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}