package main

import "sort"

func findKDistantIndices(nums []int, key int, k int) []int {
	n := len(nums)
	isKDist := make([]bool, n)

	for j := 0; j < n; j++ {
		if nums[j] == key {
			start := j - k
			if start < 0 {
				start = 0
			}
			end := j + k
			if end >= n {
				end = n - 1
			}
			for i := start; i <= end; i++ {
				isKDist[i] = true
			}
		}
	}

	var result []int
	for i := 0; i < n; i++ {
		if isKDist[i] {
			result = append(result, i)
		}
	}

	return result
}