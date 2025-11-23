import "sort"

func minIncrementForUnique(nums []int) int {
	sort.Ints(nums)
	ans := 0
	taken := 0
	for i := 0; i < len(nums); i++ {
		if i > 0 && nums[i] <= nums[i-1] {
			taken = nums[i-1] + 1
			ans += taken - nums[i]
			nums[i] = taken
		}
	}
	return ans
}