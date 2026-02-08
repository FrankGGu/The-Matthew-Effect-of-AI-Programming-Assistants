package main

func minimumRightShifts(nums []int) int {
	n := len(nums)
	for i := 0; i < n; i++ {
		if nums[i] > nums[(i+1)%n] {
			return (n - i - 1) % n
		}
	}
	return 0
}