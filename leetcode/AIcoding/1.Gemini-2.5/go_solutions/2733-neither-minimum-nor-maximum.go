import "sort"

func findNonMinMax(nums []int) int {
	sort.Ints(nums)
	return nums[1]
}