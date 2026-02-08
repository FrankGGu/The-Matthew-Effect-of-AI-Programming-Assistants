package main

import "math"

func gridGame(grid [][]int) int64 {
	n := len(grid[0])

	topSum := int64(0)
	for _, val := range grid[0] {
		topSum += int64(val)
	}

	bottomSum := int64(0)
	minMaxScore := int64(math.MaxInt64)

	for k := 0; k < n; k++ {
		// Robot 1 clears grid[0][k] and everything to its left in row 0.
		// So, the points available for Robot 2 from row 0 are to the right of k.
		// topSum initially holds sum(grid[0][0...n-1]).
		// After topSum -= grid[0][k], it represents sum(grid[0][k+1...n-1]).
		topSum -= int64(grid[0][k])

		// Robot 2's score for this k is the maximum of:
		// 1. Points from row 0, right of k (topSum).
		// 2. Points from row 1, left of k (bottomSum).
		robot2Score := max(topSum, bottomSum)

		minMaxScore = min(minMaxScore, robot2Score)

		// For the next iteration (k+1), grid[1][k] will be part of the accumulated bottomSum.
		// bottomSum accumulates sum(grid[1][0...k]).
		bottomSum += int64(grid[1][k])
	}

	return minMaxScore
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}