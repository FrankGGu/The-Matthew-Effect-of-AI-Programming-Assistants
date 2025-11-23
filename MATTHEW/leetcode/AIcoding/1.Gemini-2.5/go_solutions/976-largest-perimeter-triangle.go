import "sort"

func largestPerimeter(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	for i := n - 1; i >= 2; i-- {
		if nums[i-2]+nums[i-1] > nums[i] {
			return nums[i-2] + nums[i-1] + nums[i]
		}
	}
	return 0
}