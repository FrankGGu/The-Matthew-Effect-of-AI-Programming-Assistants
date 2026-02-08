import "math"

func maxSumDivThree(nums []int) int {
	dp := [3]int{0, math.MinInt32, math.MinInt32}

	for _, num := range nums {
		newDp := [3]int{dp[0], dp[1], dp[2]}

		for i := 0; i < 3; i++ {
			if dp[i] != math.MinInt32 {
				currentSum := dp[i] + num
				remainder := currentSum % 3
				newDp[remainder] = max(newDp[remainder], currentSum)
			}
		}
		dp = newDp
	}

	return dp[0]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}