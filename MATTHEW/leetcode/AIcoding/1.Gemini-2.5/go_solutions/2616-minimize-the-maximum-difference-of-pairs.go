package main

import (
	"sort"
)

func minimizeMax(nums []int, p int) int {
	sort.Ints(nums)
	n := len(nums)

	left := 0
	right := nums[n-1] - nums[0]
	ans := right

	for left <= right {
		mid := left + (right-left)/2

		count := 0
		i := 0
		for i < n-1 {
			if nums[i+1]-nums[i] <= mid {
				count++
				i += 2
			} else {
				i++
			}
		}

		if count >= p {
			ans = mid
			right = mid - 1
		} else {
			left = mid + 1
		}
	}

	return ans
}