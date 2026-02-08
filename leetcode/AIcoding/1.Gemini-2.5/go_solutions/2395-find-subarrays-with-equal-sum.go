package main

func findSubarrays(nums []int) bool {
	seenSums := make(map[int]bool)
	for i := 0; i < len(nums)-1; i++ {
		currentSum := nums[i] + nums[i+1]
		if seenSums[currentSum] {
			return true
		}
		seenSums[currentSum] = true
	}
	return false
}