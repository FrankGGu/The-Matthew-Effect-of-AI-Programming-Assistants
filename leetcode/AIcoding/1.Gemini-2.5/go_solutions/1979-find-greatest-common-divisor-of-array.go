package main

import "sort"

func findGCD(nums []int) int {
	minVal := nums[0]
	maxVal := nums[0]

	for i := 1; i < len(nums); i++ {
		if nums[i] < minVal {
			minVal = nums[i]
		}
		if nums[i] > maxVal {
			maxVal = nums[i]
		}
	}

	return gcd(minVal, maxVal)
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}