package main

import "math"

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func minOperations(nums []int) int {
	n := len(nums)

	onesCount := 0
	for _, num := range nums {
		if num == 1 {
			onesCount++
		}
	}

	if onesCount > 0 {
		return n - onesCount
	}

	minOpsToCreateOne := math.MaxInt32

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			currentGCD := nums[i]
			for j := i + 1; j < i+length; j++ {
				currentGCD = gcd(currentGCD, nums[j])
			}

			if currentGCD == 1 {
				minOpsToCreateOne = length - 1
				goto foundMinOps
			}
		}
	}

foundMinOps:
	if minOpsToCreateOne == math.MaxInt32 {
		return -1
	}

	return minOpsToCreateOne + (n - 1)
}