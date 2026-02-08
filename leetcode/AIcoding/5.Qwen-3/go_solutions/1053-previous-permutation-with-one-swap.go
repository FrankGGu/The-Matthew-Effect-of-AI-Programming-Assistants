package main

func prevPermOpt1(nums []int) []int {
	n := len(nums)
	i := n - 2
	for i >= 0 && nums[i] <= nums[i+1] {
		i--
	}
	if i < 0 {
		return nums
	}
	j := n - 1
	for nums[j] >= nums[i] {
		j--
	}
	for j > 0 && nums[j] == nums[j-1] {
		j--
	}
	nums[i], nums[j] = nums[j], nums[i]
	return nums
}