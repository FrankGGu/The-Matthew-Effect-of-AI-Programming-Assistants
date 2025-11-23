import "math"

func mincostTickets(days []int, costs []int) int {
	n := len(days)
	dp := make([]int, n+1)

	for i := 1; i <= n; i++ {
		dp[i] = dp[i-1] + costs[0]

		for j := i - 1; j >= 0 && days[i-1]-days[j] < 7; j-- {
			dp[i] = int(math.Min(float64(dp[i]), float64(dp[j]+costs[1])))
		}
		if days[i-1]-days[0] < 7 {
			dp[i] = int(math.Min(float64(dp[i]), float64(costs[1])))
		}

		for j := i - 1; j >= 0 && days[i-1]-days[j] < 30; j-- {
			dp[i] = int(math.Min(float64(dp[i]), float64(dp[j]+costs[2])))
		}
		if days[i-1]-days[0] < 30 {
			dp[i] = int(math.Min(float64(dp[i]), float64(costs[2])))
		}
	}

	return dp[n]
}