package main

import (
	"math"
)

type Deque []int

func (d *Deque) PushBack(idx int) {
	*d = append(*d, idx)
}

func (d *Deque) PopBack() int {
	old := *d
	n := len(old)
	val := old[n-1]
	*d = old[:n-1]
	return val
}

func (d *Deque) PopFront() int {
	old := *d
	val := old[0]
	*d = old[1:]
	return val
}

func (d *Deque) Front() int {
	return (*d)[0]
}

func (d *Deque) Back() int {
	return (*d)[len(*d)-1]
}

func (d *Deque) IsEmpty() bool {
	return len(*d) == 0
}

func (d *Deque) Len() int {
	return len(*d)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minCost(nums []int, k int, dist int) int {
	n := len(nums)

	// dp_prev stores the minimum cost to form 'm-1' subarrays, where the (m-1)-th subarray starts at index 'i'.
	// dp_curr stores the minimum cost to form 'm' subarrays, where the m-th subarray starts at index 'i'.
	dp_prev := make([]int, n)
	dp_curr := make([]int, n)

	// Base case: For 1 subarray (m=1), it must start at index 0.
	// The cost is nums[0]. All other starting positions are invalid for the first subarray.
	for i := 0; i < n; i++ {
		dp_prev[i] = math.MaxInt32
	}
	dp_prev[0] = nums[0]

	// Iterate for m from 2 to k (number of subarrays)
	for m := 2; m <= k; m++ {
		// Initialize dp_curr for the current number of subarrays
		for i := 0; i < n; i++ {
			dp_curr[i] = math.MaxInt32
		}

		// Deque to maintain minimum of dp_prev values in the sliding window [i - dist, i - 1].
		// The deque stores indices 'p' such that dp_prev[p] is increasing from front to back.
		dq := Deque{}

		// Iterate through possible starting indices 'i' for the m-th subarray.
		// The m-th subarray must start at index 'i'.
		// The (m-1)-th subarray must have started at index 'p' such that p < i <= p + dist.
		// This means 'p' must be in the range [i - dist, i - 1].
		// Also, a subarray must have at least one element. So, the m-th subarray
		// cannot start before index m-1.
		for i := m - 1; i < n; i++ {
			// Remove indices from the front of the deque that are too far left (outside the window [i - dist, i - 1]).
			// The previous starting index 'p' must be at least 'i - dist'.
			for !dq.IsEmpty() && dq.Front() < i-dist {
				dq.PopFront()
			}

			// Add dp_prev[i-1] to the deque, maintaining monotonicity.
			// We are considering dp_prev[i-1] as a potential previous cost.
			// Only consider valid dp_prev[i-1] values (not MaxInt32).
			if dp_prev[i-1] != math.MaxInt32 {
				for !dq.IsEmpty() && dp_prev[dq.Back()] >= dp_prev[i-1] {
					dq.PopBack()
				}
				dq.PushBack(i-1)
			}

			// If deque is not empty, the minimum dp_prev value for the current window is dp_prev[dq.Front()].
			if !dq.IsEmpty() {
				min_prev_cost := dp_prev[dq.Front()]
				if min_prev_cost != math.MaxInt32 {
					dp_curr[i] = nums[i] + min_prev_cost
				}
			}
		}

		// Swap dp_prev and dp_curr for the next iteration.
		dp_prev, dp_curr = dp_curr, dp_prev
	}

	// The final answer is the minimum value in dp_prev (which now holds dp[i][k]).
	// This is the minimum cost to form 'k' subarrays, where the k-th subarray starts at index 'i'.
	// The k-th subarray must start at or after index k-1 (since each subarray has length >= 1).
	// The k-th subarray can start at any index up to n-1.

	final_min_cost := math.MaxInt32
	for i := k - 1; i < n; i++ {
		final_min_cost = min(final_min_cost, dp_prev[i])
	}

	return final_min_cost
}