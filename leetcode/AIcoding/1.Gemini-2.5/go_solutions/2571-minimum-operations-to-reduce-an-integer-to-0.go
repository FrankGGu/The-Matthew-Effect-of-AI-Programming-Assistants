package main

import "math"

var memo map[int]int

func minOperations(n int) int {
	memo = make(map[int]int)
	return solve(n)
}

func solve(n int) int {
	if n == 0 {
		return 0
	}
	if n == 1 {
		return 1
	}

	if val, ok := memo[n]; ok {
		return val
	}

	var ans int
	if n%2 == 0 {
		ans = solve(n / 2)
	} else {
		ans = min(solve(n-1)+1, solve(n+1)+1)
	}

	memo[n] = ans
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}