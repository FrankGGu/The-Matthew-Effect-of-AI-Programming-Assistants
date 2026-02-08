import "sort"

func minOperations(nums []int, target int) int {
	sum := 0
	for _, num := range nums {
		sum += num
	}
	if sum < target {
		return -1
	}

	sort.Ints(nums)
	operations := 0
	for i := len(nums) - 1; i >= 0; i-- {
		if target == 0 {
			break
		}
		if nums[i] <= target {
			target -= nums[i]
		} else {
			operations++
			nums = append(nums, nums[i]/2)
			nums = append(nums, nums[i]/2)
			nums = append(nums[:i], nums[i+1:]...)
			sort.Ints(nums)
			i = len(nums)
		}
	}
	return operations
}