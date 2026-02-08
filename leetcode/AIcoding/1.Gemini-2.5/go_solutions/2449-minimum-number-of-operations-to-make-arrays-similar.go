package main

import (
	"sort"
)

func minOperations(nums []int, target []int) int64 {
	var numsEven, numsOdd []int
	var targetEven, targetOdd []int

	for _, num := range nums {
		if num%2 == 0 {
			numsEven = append(numsEven, num)
		} else {
			numsOdd = append(numsOdd, num)
		}
	}

	for _, num := range target {
		if num%2 == 0 {
			targetEven = append(targetEven, num)
		} else {
			targetOdd = append(targetOdd, num)
		}
	}

	sort.Ints(numsEven)
	sort.Ints(numsOdd)
	sort.Ints(targetEven)
	sort.Ints(targetOdd)

	var totalIncrease int64

	// Calculate total amount to be increased for even numbers
	// Since an even number can only interact with another even number (due to parity preservation when x is even,
	// or maintaining same parity after operation when x is odd),
	// we match the smallest even number in nums with the smallest even number in target, and so on.
	for i := 0; i < len(numsEven); i++ {
		if numsEven[i] < targetEven[i] {
			totalIncrease += int64(targetEven[i] - numsEven[i])
		}
	}

	// Calculate total amount to be increased for odd numbers
	// Similarly, odd numbers only interact with odd numbers.
	for i := 0; i < len(numsOdd); i++ {
		if numsOdd[i] < targetOdd[i] {
			totalIncrease += int64(targetOdd[i] - numsOdd[i])
		}
	}

	// The problem states "simultaneously increase nums[i] by x and decrease nums[j] by x".
	// This is one operation that moves 'x' units of value.
	// The total amount of value that needs to be increased across all elements (totalIncrease)
	// must be equal to the total amount of value that needs to be decreased.
	// Each operation effectively accounts for 'x' units of increase and 'x' units of decrease.
	// Therefore, the total 'flow' of value is totalIncrease.
	// Since each operation involves two ends (one increasing, one decreasing),
	// it reduces the total 'increase needed' by 'x' and total 'decrease needed' by 'x'.
	// The minimum number of operations is totalIncrease / 2.
	// This is a standard result for this type of balancing problem where 'x' can be any positive integer.

	return totalIncrease / 2
}