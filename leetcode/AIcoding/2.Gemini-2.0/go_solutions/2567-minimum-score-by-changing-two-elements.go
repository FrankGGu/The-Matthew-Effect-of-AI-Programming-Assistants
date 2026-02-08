import (
	"sort"
)

func minimizeSum(nums []int) int {
	n := len(nums)
	sort.Ints(nums)
	return min(nums[n-1]-nums[2], min(nums[n-3]-nums[0], nums[n-2]-nums[1]))
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}