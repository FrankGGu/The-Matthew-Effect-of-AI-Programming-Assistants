package main

import (
	"math"
)

func findRotateSteps(ring string, key string) int {
	n := len(ring)
	m := len(key)

	// prev_dp stores min steps to spell key[k_idx-1] ending with ring[ring_idx] at 12 o'clock
	// current_dp stores min steps to spell key[k_idx] ending with ring[ring_idx] at 12 o'clock
	prev_dp := make(map[int]int)

	// Base case: first character of key (key[0])
	// Initial 12 o'clock position is ring[0]
	for i := 0; i < n; i++ {
		if ring[i] == key[0] {
			prev_dp[i] = minDistance(n, 0, i) + 1 // +1 for pressing the button
		}
	}

	// Iterate for subsequent characters of key
	for k_idx := 1; k_idx < m; k_idx++ {
		curr_dp := make(map[int]int)

		// Find all positions in ring that match key[k_idx]
		for i := 0; i < n; i++ {
			if ring[i] == key[k_idx] {
				min_cost_for_this_pos := math.MaxInt32

				// Iterate over all possible previous ring positions
				for prev_ring_pos, prev_cost := range prev_dp {
					cost := prev_cost + minDistance(n, prev_ring_pos, i) + 1 // +1 for pressing button
					if cost < min_cost_for_this_pos {
						min_cost_for_this_pos = cost
					}
				}
				curr_dp[i] = min_cost_for_this_pos
			}
		}
		prev_dp = curr_dp
	}

	// Find the minimum cost from the last character's DP state
	min_total_steps := math.MaxInt32
	for _, cost := range prev_dp {
		if cost < min_total_steps {
			min_total_steps = cost
		}
	}

	return min_total_steps
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minDistance(n, from, to int) int {
	dist := abs(from - to)
	return min(dist, n-dist)
}