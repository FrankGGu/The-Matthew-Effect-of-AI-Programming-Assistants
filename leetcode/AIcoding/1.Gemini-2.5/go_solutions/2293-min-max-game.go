package main

func minMaxGame(nums []int) int {
	for len(nums) > 1 {
		n := len(nums)
		newNums := make([]int, n/2)
		for i := 0; i < n/2; i++ {
			if i%2 == 0 {
				if nums[2*i] < nums[2*i+1] {
					newNums[i] = nums[2*i]
				} else {
					newNums[i] = nums[2*i+1]
				}
			} else {
				if nums[2*i] > nums[2*i+1] {
					newNums[i] = nums[2*i]
				} else {
					newNums[i] = nums[2*i+1]
				}
			}
		}
		nums = newNums
	}
	return nums[0]
}