package main

import (
	"container/list"
)

func minimumOperationsToMakeEqual(x int, y int) int {
	if x == y {
		return 0
	}

	queue := list.New()
	// dist[num] stores the minimum number of operations to reach 'num' from 'x'.
	dist := make(map[int]int)

	// Start BFS from x with 0 operations.
	queue.PushBack([2]int{x, 0}) // [current_number, operations_count]
	dist[x] = 0

	for queue.Len() > 0 {
		front := queue.Front()
		currArr := front.Value.([2]int)
		curr := currArr[0]
		ops := currArr[1]
		queue.Remove(front)

		// If we reached y, this is the shortest path because it's a BFS on an unweighted graph.
		if curr == y {
			return ops
		}

		// Explore possible next states
		// Operation 1: x / 11
		if curr%11 == 0 {
			nextNum := curr / 11
			if _, found := dist[nextNum]; !found || dist[nextNum] > ops+1 {
				dist[nextNum] = ops + 1
				queue.PushBack([2]int{nextNum, ops + 1})
			}
		}

		// Operation 2: x / 5
		if curr%5 == 0 {
			nextNum := curr / 5
			if _, found := dist[nextNum]; !found || dist[nextNum] > ops+1 {
				dist[nextNum] = ops + 1
				queue.PushBack([2]int{nextNum, ops + 1})
			}
		}

		// Operation 3: x - 1
		nextNumMinus1 := curr - 1
		// Ensure the number remains non-negative.
		// Problem constraints state 1 <= x, y <= 10^9, so y is never 0.
		// However, 0 can be an intermediate state (e.g., 1 - 1 = 0).
		if nextNumMinus1 >= 0 {
			if _, found := dist[nextNumMinus1]; !found || dist[nextNumMinus1] > ops+1 {
				dist[nextNumMinus1] = ops + 1
				queue.PushBack([2]int{nextNumMinus1, ops + 1})
			}
		}

		// Operation 4: x + 1
		nextNumPlus1 := curr + 1
		// No explicit upper bound check for nextNumPlus1 is strictly necessary for correctness.
		// The BFS naturally explores the shortest paths, and the 'dist' map prunes longer paths.
		// The number of effectively visited states will be manageable due to the division operations
		// quickly reducing large numbers, and +1 operations being primarily useful for small adjustments
		// or reaching multiples of 5 or 11.
		if _, found := dist[nextNumPlus1]; !found || dist[nextNumPlus1] > ops+1 {
			dist[nextNumPlus1] = ops + 1
			queue.PushBack([2]int{nextNumPlus1, ops + 1})
		}
	}

	// This part should theoretically not be reached because it's always possible
	// to reach y from x using only +1 or -1 operations.
	return -1
}