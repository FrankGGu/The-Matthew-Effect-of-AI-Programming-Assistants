package main

func minimizeArrayValue(nums []int) int {
	low := 0
	high := 1000000000 // Maximum possible value for nums[i]

	ans := high

	for low <= high {
		mid := low + (high-low)/2
		if check(nums, mid) {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}

	return ans
}

func check(nums []int, target int) bool {
	var currentSum int64
	for i := 0; i < len(nums); i++ {
		currentSum += int64(nums[i])
		// The average of the prefix nums[0...i] must not exceed target.
		// currentSum / (i+1) <= target
		// currentSum <= (i+1) * target
		if currentSum > int64(i+1)*int64(target) {
			return false
		}
	}
	return true
}