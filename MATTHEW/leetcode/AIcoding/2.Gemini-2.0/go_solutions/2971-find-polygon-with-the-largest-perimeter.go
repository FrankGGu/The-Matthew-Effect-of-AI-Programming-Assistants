import "sort"

func largestPerimeter(nums []int) int {
	sort.Ints(nums)
	sum := 0
	for _, num := range nums {
		sum += num
	}
	for i := len(nums) - 1; i >= 2; i-- {
		sum -= nums[i]
		if sum > nums[i] {
			return sum + nums[i]
		}
	}
	return -1
}