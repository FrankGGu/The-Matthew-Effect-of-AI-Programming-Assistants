package main

import "math"

func findMinMoves(machines []int) int {
	n := len(machines)
	totalDresses := 0
	for _, m := range machines {
		totalDresses += m
	}

	if totalDresses%n != 0 {
		return -1
	}

	target := totalDresses / n
	maxMoves := 0
	balance := 0

	for _, m := range machines {
		diff := m - target
		balance += diff

		// The number of moves is at least the maximum excess dresses in any single machine
		// (which must be moved out).
		if diff > maxMoves {
			maxMoves = diff
		}

		// The number of moves is also at least the maximum absolute imbalance
		// (dresses that must pass through a point).
		absBalance := int(math.Abs(float64(balance)))
		if absBalance > maxMoves {
			maxMoves = absBalance
		}
	}

	return maxMoves
}