package main

import (
	"sort"
)

func rearrangeArray(nums []int) []int {
	sort.Ints(nums)
	n := len(nums)
	result := make([]int, n)

	left := 0
	right := n - 1

	for i := 0; i < n; i++ {
		if i%2 == 0 {
			result[i] = nums[left]
			left++
		} else {
			result[i] = nums[right]
			right--
		}
	}

	return result
}