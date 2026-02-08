import "math"

func minCost(costs [][]int) int {
	n := len(costs)
	if n == 0 {
		return 0
	}

	// dp0, dp1, dp2 represent the minimum cost to paint the current house with color 0, 1, or 2 respectively.
	// We initialize them with the costs of painting the first house.
	dp0 := costs[0][0]
	dp1 := costs[0][1]
	dp2 := costs[0][2]

	for i := 1; i < n; i++ {
		// Calculate the new minimum costs for the current house (i)
		// based on the minimum costs of painting the previous house (i-1)
		// with a different color.
		new_dp0 := costs[i][0] + int(math.Min(float64(dp1), float64(dp2)))
		new_dp1 := costs[i][1] + int(math.Min(float64(dp0), float64(dp2)))
		new_dp2 := costs[i][2] + int(math.Min(float64(dp0), float64(dp1)))

		// Update dp values for the next iteration
		dp0 = new_dp0
		dp1 = new_dp1
		dp2 = new_dp2
	}

	// The minimum cost to paint all houses is the minimum of painting the last house
	// with any of the three colors.
	return int(math.Min(float64(dp0), math.Min(float64(dp1), float64(dp2))))
}