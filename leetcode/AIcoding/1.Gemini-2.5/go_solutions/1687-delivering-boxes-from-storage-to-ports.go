package main

import (
	"math"
)

func boxDelivering(boxes [][]int, portsCount int, maxWeight int, maxBoxes int) int {
	n := len(boxes)

	// dp[i] represents the minimum trips to deliver the first i boxes (boxes from index 0 to i-1).
	// dp[0] is 0 as no boxes delivered.
	dp := make([]int, n+1)
	dp[0] = 0

	// prefixPortChangeCost[k] stores the number of port changes among boxes from index 0 to k-1.
	// For example, prefixPortChangeCost[k] = sum(1 if boxes[x][0] != boxes[x-1][0] for x from 1 to k-1).
	// This means prefixPortChangeCost[k] counts changes up to the (k-1)-th box.
	// The number of port changes for a segment [j, i-1] is prefixPortChangeCost[i] - prefixPortChangeCost[j].
	prefixPortChangeCost := make([]int, n+1)
	prefixPortChangeCost[0] = 0 // No boxes, no changes
	for k := 1; k <= n; k++ {
		prefixPortChangeCost[k] = prefixPortChangeCost[k-1]
		// Check for change between box k-1 and box k-2
		if k >= 2 && boxes[k-1][0] != boxes[k-2][0] {
			prefixPortChangeCost[k]++
		}
	}

	// Deque (double-ended queue) to maintain indices j that minimize (dp[j] - prefixPortChangeCost[j]).
	// q stores indices j in increasing order, and (dp[j] - prefixPortChangeCost[j]) values are also increasing.
	q := []int{0} // Index 0 is a valid starting point for the first trip.

	currentWeight := 0
	currentBoxes := 0
	left := 0 // `left` is the leftmost valid starting index for a trip ending at `i-1`.

	for i := 1; i <= n; i++ {
		// Add box i-1 to the current window [left, i-1]
		currentWeight += boxes[i-1][1]
		currentBoxes++

		// Shrink the window from the left if constraints (maxWeight or maxBoxes) are violated.
		// `left` is adjusted to ensure the segment [left, i-1] is valid.
		for currentWeight > maxWeight || currentBoxes > maxBoxes {
			currentWeight -= boxes[left][1]
			currentBoxes--
			left++
		}

		// Remove invalid indices from the front of the deque.
		// An index `j` is invalid if it's less than `left`, meaning a trip starting at `j`
		// and ending at `i-1` would violate `maxWeight` or `maxBoxes` constraints.
		for len(q) > 0 && q[0] < left {
			q = q[1:]
		}

		// Calculate dp[i] using the minimum value from the front of the deque.
		// The recurrence is: dp[i] = min(dp[j] + 2 + (prefixPortChangeCost[i] - prefixPortChangeCost[j]))
		// Rearranging: dp[i] = min( (dp[j] - prefixPortChangeCost[j]) ) + prefixPortChangeCost[i] + 2
		dp[i] = dp[q[0]] - prefixPortChangeCost[q[0]] + prefixPortChangeCost[i] + 2

		// Add `i` as a potential starting point for future trips to the deque.
		// Before adding, remove indices from the back of the deque that are "worse" than `i`.
		// An index `k` is worse than `i` if (dp[k] - prefixPortChangeCost[k]) >= (dp[i] - prefixPortChangeCost[i]).
		// This maintains the monotonic property of the deque.
		for len(q) > 0 && (dp[q[len(q)-1]]-prefixPortChangeCost[q[len(q)-1]]) >= (dp[i]-prefixPortChangeCost[i]) {
			q = q[:len(q)-1]
		}
		q = append(q, i)
	}

	return dp[n]
}