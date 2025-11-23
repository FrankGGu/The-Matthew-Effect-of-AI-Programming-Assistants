func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minRunes(runes []int, reserve_target int) int {
	infinity := reserve_target + 1
	dp := make([]int, reserve_target+1)

	dp[0] =