package main

import (
	"math"
)

func maxManhattanDistanceAfterKChanges(points [][]int, k int) int64 {
	var MAX_COORD int64 = 1_000_000_000

	var ans int64 = 0

	// Initialize min/max values for k=0 and k=1 calculations
	var minSum int64 = math.MaxInt64
	var maxSum int64 = math.MinInt64
	var minDiff int64 = math.MaxInt64
	var maxDiff int64 = math.MinInt64

	var minX int64 = math.MaxInt64
	var maxX int64 = math.MinInt64
	var minY int64 = math.MaxInt64
	var maxY int64 = math.MinInt64

	for _, p := range points {
		x := int64(p[0])
		y := int64(p[1])

		currentSum := x + y
		currentDiff := x - y

		minSum = min(minSum, currentSum)
		maxSum = max(maxSum, currentSum)
		minDiff = min(minDiff, currentDiff)
		maxDiff = max(maxDiff, currentDiff)

		minX = min(minX, x)
		maxX = max(maxX, x)
		minY = min(minY, y)
		maxY = max(maxY, y)
	}

	// Case k=0: No changes. Maximize |x_i - x_j| + |y_i - y_j|.
	// This is equivalent to max(max(x+y) - min(x+y), max(x-y) - min(x-y)).
	ans = max(ans, maxSum-minSum)
	ans = max(ans, maxDiff-minDiff)

	if k == 0 {
		return ans
	}

	// Case k=1: At most one coordinate can be changed.
	// We can change x_i or y_i of one point (say p_i) to maximize distance to another point p_j.
	// The new coordinate can be any integer in [-MAX_COORD, MAX_COORD].
	// To maximize |coord' - coord_j|, we set coord' to MAX_COORD or -MAX_COORD.
	// Specifically, max(|coord' - coord_j|) = MAX_COORD + abs(coord_j).

	// Option 1: Change x_i to x_i'. Maximize (MAX_COORD + abs(x_j)) + |y_i - y_j|.
	// This is MAX_COORD + max_{i,j} (abs(x_j) + |y_i - y_j|).
	// To find max_{i,j} (abs(x_j) + |y_i - y_j|), we iterate over all p_j.
	// For each p_j, we need to find max_i(|y_i - y_j|), which is max(maxY - y_j, y_j - minY).
	var maxValK1Option1 int64 = 0 // Stores max_{j} (abs(x_j) + max_i(|y_i - y_j|))
	for _, p_j := range points {
		x_j := int64(p_j[0])
		y_j := int64(p_j[1])

		currentMaxYDiff := max(maxY-y_j, y_j-minY)
		maxValK1Option1 = max(maxValK1Option1, abs(x_j)+currentMaxYDiff)
	}
	ans = max(ans, MAX_COORD+maxValK1Option1)

	// Option 2: Change y_i to y_i'. Maximize |x_i - x_j| + (MAX_COORD + abs(y_j)).
	// This is MAX_COORD + max_{i,j} (|x_i - x_j| + abs(y_j)).
	// To find max_{i,j} (|x_i - x_j| + abs(y_j)), we iterate over all p_j.
	// For each p_j, we need to find max_i(|x_i - x_j|), which is max(maxX - x_j, x_j - minX).
	var maxValK1Option2 int64 = 0 // Stores max_{j} (max_i(|x_i - x_j|) + abs(y_j))
	for _, p_j := range points {
		x_j := int64(p_j[0])
		y_j := int64(p_j[1])

		currentMaxXDiff := max(maxX-x_j, x_j-minX)
		maxValK1Option2 = max(maxValK1Option2, currentMaxXDiff+abs(y_j))
	}
	ans = max(ans, MAX_COORD+maxValK1Option2)

	if k == 1 {
		return ans
	}

	// Case k=2: At most two coordinates can be changed.
	// We can change both x_i and y_i of p_i to maximize distance to p_j.
	// Maximize |x_i' - x_j| + |y_i' - y_j|.
	// This becomes (MAX_COORD + abs(x_j)) + (MAX_COORD + abs(y_j)) = 2 * MAX_COORD + abs(x_j) + abs(y_j).
	// We need to maximize this over all p_j.
	// So, 2 * MAX_COORD + max_j (abs(x_j) + abs(y_j)).
	var maxValK2 int64 = 0 // Stores max_j (abs(x_j) + abs(y_j))
	for _, p_j := range points {
		x_j := int64(p_j[0])
		y_j := int64(p_j[1])
		maxValK2 = max(maxValK2, abs(x_j)+abs(y_j))
	}
	ans = max(ans, 2*MAX_COORD+maxValK2)

	return ans
}

func abs(a int64) int64 {
	if a < 0 {
		return -a
	}
	return a
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