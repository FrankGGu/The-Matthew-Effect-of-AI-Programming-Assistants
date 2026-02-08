package main

func minimizeSum(nums []int) int {
	if len(nums) <= 3 {
		return 0
	}
	sort.Ints(nums)
	n := len(nums)
	return min(nums[n-3]-nums[0], min(nums[n-2]-nums[1], nums[n-1]-nums[2]))
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}