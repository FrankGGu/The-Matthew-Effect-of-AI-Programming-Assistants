package main

import (
	"math"
)

func minCapability(nums []int, k int) int {
	n := len(nums)

	check := func(max_val int) int {
		count := 0
		for i := 0; i < n; {
			if nums[i] <= max_val {
				count++
				i += 2
			} else {
				i += 1
			}
		}
		return count
	}

	left := 0
	max_num := 0
	for _, num := range nums {
		if num > max_num {
			max_num = num
		}
	}
	right := max_num

	ans := math.MaxInt32

	for left <= right {
		mid := left + (right-left)/2

		if check(mid) >= k {
			ans = mid
			right = mid - 1
		} else {
			left = mid + 1
		}
	}

	return ans
}