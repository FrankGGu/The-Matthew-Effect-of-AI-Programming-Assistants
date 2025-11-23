package main

func smallestSubarrays(nums []int) []int {
	n := len(nums)
	result := make([]int, n)
	for i := range nums {
		result[i] = 1
	}
	for i := 0; i < n; i++ {
		currentOR := nums[i]
		for j := i; j < n; j++ {
			currentOR |= nums[j]
			if j-i+1 < result[i] {
				result[i] = j - i + 1
			}
		}
	}
	return result
}