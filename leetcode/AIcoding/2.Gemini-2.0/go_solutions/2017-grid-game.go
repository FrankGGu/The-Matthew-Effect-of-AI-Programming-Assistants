import "sort"

func gridGame(grid [][]int) int64 {
	n := len(grid[0])
	prefixSumTop := make([]int64, n+1)
	prefixSumBottom := make([]int64, n+1)

	for i := 0; i < n; i++ {
		prefixSumTop[i+1] = prefixSumTop[i] + int64(grid[0][i])
		prefixSumBottom[i+1] = prefixSumBottom[i] + int64(grid[1][i])
	}

	ans := int64(1e18)
	for i := 0; i < n; i++ {
		top := prefixSumTop[n] - prefixSumTop[i+1]
		bottom := prefixSumBottom[i]

		ans = min(ans, max(top, bottom))
	}

	return ans
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}