import "sort"

func minDifference(nums []int) int {
	n := len(nums)
	if n <= 4 {
		return 0
	}
	sort.Ints(nums)
	return min(min(nums[n-1]-nums[3], nums[n-2]-nums[2]), min(nums[n-3]-nums[1], nums[n-4]-nums[0]))
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}