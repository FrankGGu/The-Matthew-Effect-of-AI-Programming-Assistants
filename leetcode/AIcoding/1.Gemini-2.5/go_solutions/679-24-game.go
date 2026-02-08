package main

import (
	"math"
)

const EPSILON = 1e-6

func judgePoint24(cards []int) bool {
	nums := make([]float64, len(cards))
	for i, card := range cards {
		nums[i] = float64(card)
	}
	return solve(nums)
}

func solve(nums []float64) bool {
	if len(nums) == 1 {
		return math.Abs(nums[0]-24.0) < EPSILON
	}

	n := len(nums)
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			nextNums := make([]float64, 0, n-1)
			for k := 0; k < n; k++ {
				if k != i && k != j {
					nextNums = append(nextNums, nums[k])
				}
			}

			// Try all 6 possible operations for the pair (nums[i], nums[j])
			// and recurse with the result added to nextNums.
			// If any path leads to 24, return true.

			// Operation 1: Addition
			if solve(append(nextNums, nums[i]+nums[j])) {
				return true
			}
			// Operation 2: Subtraction (nums[i] - nums[j])
			if solve(append(nextNums, nums[i]-nums[j])) {
				return true
			}
			// Operation 3: Subtraction (nums[j] - nums[i])
			if solve(append(nextNums, nums[j]-nums[i])) {
				return true
			}
			// Operation 4: Multiplication
			if solve(append(nextNums, nums[i]*nums[j])) {
				return true
			}
			// Operation 5: Division (nums[i] / nums[j])
			if math.Abs(nums[j]) > EPSILON { // Avoid division by zero
				if solve(append(nextNums, nums[i]/nums[j])) {
					return true
				}
			}
			// Operation 6: Division (nums[j] / nums[i])
			if math.Abs(nums[i]) > EPSILON { // Avoid division by zero
				if solve(append(nextNums, nums[j]/nums[i])) {
					return true
				}
			}
		}
	}
	return false
}