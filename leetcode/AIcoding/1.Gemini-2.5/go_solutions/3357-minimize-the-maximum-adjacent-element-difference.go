package main

import (
	"sort"
)

func minimizeMax(nums []int, p int) int {
	sort.Ints(nums)
	n := len(nums)

	low := 0
	high := nums[n-1] - nums[0]
	ans := high

	for low <= high {
		mid := low + (high-low)/2
		if check(mid, nums, p) {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}
	return ans
}

func check(mid int, nums []int, p int) bool {
	count := 0
	i := 0
	for i < len(nums)-1 {
		if nums[i+1]-nums[i] <= mid {
			count++
			i += 2
		} else {
			i += 1
		}
		if count >= p {
			return true
		}
	}
	return false
}