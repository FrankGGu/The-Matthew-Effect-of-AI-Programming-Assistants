package main

import (
	"math"
)

var memo map[int]int

func minDays(n int) int {
	// Initialize memo map for each test case
	memo = make(map[int]int)
	return solve(n)
}

func solve(n int) int {
	// Base cases
	if n <= 1 {
		return n // 0 days for 0 oranges, 1 day for 1 orange
	}

	// Check if already computed
	if val, ok := memo[n]; ok {
		return val
	}

	// Calculate the minimum days using two primary strategies:
	// 1. Reduce n to n/2: This involves eating (n % 2) oranges one by one
	//    to make n even, then performing the n/2 operation.
	//    Cost: (n % 2) days (for single eats) + 1 day (for n/2 operation) + solve(n/2) days.
	// 2. Reduce n to n/3: This involves eating (n % 3) oranges one by one
	//    to make n divisible by 3, then performing the n/3 operation.
	//    Cost: (n % 3) days (for single eats) + 1 day (for n/3 operation) + solve(n/3) days.

	// The `n-1` operation is implicitly covered by these two strategies.
	// For example, to go from `n` to `n/2`, if `n` is odd, we must eat 1 orange
	// (cost `1`) to make it `n-1`, then proceed with `(n-1)/2`.
	// This is captured by `(n % 2) + 1 + solve(n/2)`.
	// If `n` is odd, `n % 2` is `1`. So it's `1 + 1 + solve(n/2)`.
	// If `n` is even, `n % 2` is `0`. So it's `0 + 1 + solve(n/2)`.

	// Calculate the cost for the n/2 path
	costToNby2 := (n % 2) + 1 + solve(n/2)

	// Calculate the cost for the n/3 path
	costToNby3 := (n % 3) + 1 + solve(n/3)

	// The minimum of these two options is the result for n
	res := int(math.Min(float64(costToNby2), float64(costToNby3)))

	memo[n] = res
	return res
}