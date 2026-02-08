package main

import (
	"container/list"
)

func minReverseOperations(n int, p int, forbidden []int, k int) []int {
	ans := make([]int, n)
	for i := range ans {
		ans[i] = -1
	}

	// DSU-like structure for skipping visited/forbidden nodes
	// parent[i] stores the next available index >= i
	// An index is "available" if it's not forbidden and not yet visited.
	parent := make([]int, n+1) // Size n+1 to include a sentinel at index n
	for i := 0; i <= n; i++ {
		parent[i] = i
	}

	var find func(i int) int
	find = func(i int) int {
		if parent[i] == i {
			return i
		}
		parent[i] = find(parent[i]) // Path compression
		return parent[i]
	}

	// Mark forbidden positions as unavailable
	for _, f := range forbidden {
		parent[f] = f + 1
	}

	q := list.New()

	ans[p] = 0
	q.PushBack(p)
	parent[p] = p + 1 // Mark starting position p as visited by making it point to the next index

	for q.Len() > 0 {
		u := q.Remove(q.Front()).(int)

		// Calculate the range of L (start index of a subarray of length k)
		// such that u is contained within [L, L+k-1] and [L, L+k-1] is within [0, n-1].
		// From L <= u <= L+k-1, we get u-k+1 <= L <= u.
		// From 0 <= L and L+k-1 <= n-1, we get 0 <= L <= n-k.
		// Combining these: L_start = max(0, u-k+1), L_end = min(n-k, u).
		L_start := max(0, u-k+1)
		L_end := min(n-k, u)

		// Calculate the range of target positions v reachable from u.
		// When subarray [L, L+k-1] is reversed, u moves to L + (k-1 - (u-L)) = 2*L + k - 1 - u.
		v_lower_bound := 2*L_start + k - 1 - u
		v_upper_bound := 2*L_end + k - 1 - u

		// All reachable v positions from u have the same parity as (u + k - 1).
		target_parity := (u + k - 1) % 2

		// Iterate through potential target positions in the range [v_lower_bound, v_upper_bound]
		// using the DSU-like structure to efficiently skip already visited/forbidden nodes.
		curr_v := find(v_lower_bound)

		for curr_v <= v_upper_bound {
			if curr_v >= n { // Ensure curr_v is within [0, n-1]
				break
			}

			if curr_v%2 == target_parity {
				// curr_v is an available (not forbidden, not yet visited) node with the correct parity.
				ans[curr_v] = ans[u] + 1
				q.PushBack(curr_v)
				parent[curr_v] = find(curr_v + 1) // Mark curr_v as visited (path compression)
			}
			// Move to the next available index for the next iteration.
			// This effectively skips any visited or forbidden nodes between curr_v and the next available one.
			curr_v = find(curr_v + 1)
		}
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}