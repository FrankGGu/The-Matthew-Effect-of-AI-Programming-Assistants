import "math"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximumScore(nums []int, multipliers []int) int {
	n := len(nums)
	m := len(multipliers)

	// dp[i][j