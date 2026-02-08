import "math"

func mincostTickets(days []int, costs []int) int {
	maxDay := days[len(days)-1]

	isTravelDay := make([]bool, maxDay+1)
	for _, day := range days {
		isTravelDay[day] = true
	}

	dp := make([]int, maxDay+1)

	for i := 1; i <= maxDay; i++ {
		if !isTravelDay[i] {
			dp[i] = dp[i-1]
		} else {
			cost1Day := dp[i-1] + costs[0]

			prevDay7 := int(math.Max(0, float64(i-7)))
			cost7Day := dp[prevDay7] + costs[1]

			prevDay30 := int(math.Max(0, float64(i-30)))
			cost30Day := dp[prevDay30] + costs[2]

			dp[i] = int(math.Min(float64(cost1Day), math.Min(float64(cost7Day), float64(cost30Day))))
		}
	}

	return dp[maxDay]
}