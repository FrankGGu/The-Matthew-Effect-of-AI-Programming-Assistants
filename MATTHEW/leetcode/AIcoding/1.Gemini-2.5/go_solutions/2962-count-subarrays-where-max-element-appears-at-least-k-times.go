package main

import "math"

func countSubarrays(nums []int, k int) int64 {
	n := len(nums)
	if n == 0 {
		return 0
	}

	maxVal := 0
	for _, num := range nums {
		if num > maxVal {
			maxVal = num
		}
	}

	var ans int64 = 0
	left := 0
	countMaxVal := 0

	for right := 0; right < n; right++ {
		if nums[right] == maxVal {
			countMaxVal++
		}

		for countMaxVal >= k {
			ans += int64(n - right)
			if nums[left] == maxVal {
				countMaxVal--
			}
			left++
		}
	}

	return ans
}