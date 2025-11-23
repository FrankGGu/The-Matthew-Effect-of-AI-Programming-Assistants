import "math"

func maxProfit(prices []int) int {
	if len(prices) <= 1 {
		return 0
	}

	buy := make([]int, len(prices))
	sell := make([]int, len(prices))
	cooldown := make([]int, len(prices))

	buy[0] = -prices[0]
	sell[0] = 0
	cooldown[0] = 0

	for i := 1; i < len(prices); i++ {
		buy[i] = max(buy[i-1], cooldown[i-1]-prices[i])
		sell[i] = buy[i-1] + prices[i]
		cooldown[i] = max(cooldown[i-1], sell[i-1])
		cooldown[i] = max(cooldown[i], buy[i-1]) 
	}

	return max(sell[len(prices)-1], cooldown[len(prices)-1])
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}