import (
	"sort"
)

func matrixSum(nums [][]int) int {
	m := len(nums)
	n := len(nums[0])
	for i := 0; i < m; i++ {
		sort.Ints(nums[i])
	}
	ans := 0
	for j := 0; j < n; j++ {
		maxVal := 0
		for i := 0; i < m; i++ {
			maxVal = max(maxVal, nums[i][j])
		}
		ans += maxVal
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}