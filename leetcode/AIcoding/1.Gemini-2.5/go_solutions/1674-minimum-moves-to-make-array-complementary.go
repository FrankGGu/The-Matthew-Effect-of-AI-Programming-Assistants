package main

import "math"

func minMoves(nums []int, limit int) int {
	n := len(nums)
	// The maximum possible sum for a pair is limit + limit = 2 * limit.
	// The minimum possible sum is 1 + 1 = 2.
	// The diff array will store changes in moves for each possible sum k.
	// Index k in diff array corresponds to sum k.
	// Max index needed is 2 * limit + 1 (for diff[2*limit+1]++).
	diff := make([]int, 2*limit+2)

	// Process each pair (nums[i], nums[n-1-i])
	for i := 0; i < n/2; i++ {
		a := nums[i]
		b := nums[n-1-i]

		x := a
		y := b
		if a > b {
			x = b
			y = a
		}

		// All sums k initially require 2 moves per pair (total n moves).
		//
		// 1. For sums k in the range [1 + x, limit + y], only 1 move is needed.
		//    This means we save 1 move compared to the default 2 moves.
		//    So, at k = 1 + x, the current_moves decreases by 1.
		diff[1+x]--
		//    At k = limit + y + 1, the current_moves increases by 1 (reverting to 2 moves).
		diff[limit+y+1]++

		// 2. For the specific sum k = a + b, 0 moves are needed.
		//    This means we save another 1 move compared to the 1-move range (total 2 moves saved from default 2).
		//    So, at k = a + b, the current_moves decreases by 1.
		diff[a+b]--
		//    At k = a + b + 1, the current_moves increases by 1 (reverting to 1 move).
		diff[a+b+1]++
	}

	// Calculate minimum total moves using the diff array (sweep line algorithm).
	// Initial state: all n/2 pairs require 2 moves, so total n moves.
	currentMoves := n
	minTotalMoves := n

	// Iterate through all possible sums k from 2 to 2 * limit.
	for k := 2; k <= 2*limit; k++ {
		currentMoves += diff[k]
		if currentMoves < minTotalMoves {
			minTotalMoves = currentMoves
		}
	}

	return minTotalMoves
}