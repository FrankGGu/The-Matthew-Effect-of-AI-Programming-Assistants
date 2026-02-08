func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func maxStrength(nums []int, k int) int64 {
	n := len(nums)

	// prefix