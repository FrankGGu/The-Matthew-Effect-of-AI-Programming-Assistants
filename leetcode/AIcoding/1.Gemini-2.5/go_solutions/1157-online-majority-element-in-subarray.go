package main

import (
	"math/rand"
	"sort"
	"time"
)

type MajorityChecker struct {
	arr []int
	pos map[int][]int
}

func Constructor(arr []int) MajorityChecker {
	// Seed the random number generator once for the entire application.
	// This ensures different random sequences across different test runs.
	rand.Seed(time.Now().UnixNano())

	// Precompute positions for each unique value in the array.
	// This allows for O(log N) lookup of counts in a range.
	pos := make(map[int][]int)
	for i, v := range arr {
		pos[v] = append(pos[v], i)
	}

	return MajorityChecker{
		arr: arr,
		pos: pos,
	}
}

func (mc *MajorityChecker) Query(left int, right int, threshold int) int {
	// For online majority element problems, a randomized approach is often used.
	// We pick a small, constant number of random elements from the subarray
	// and check if any of them qualify as a majority element.
	// If a true majority element exists, there's a high probability of picking it.
	// A typical number of attempts is around 20-30.
	attempts := 20

	for i := 0; i < attempts; i++ {
		// Pick a random index within the query range [left, right].
		// rand.Intn(n) returns a non-negative pseudo-random int in [0, n).
		// So, rand.Intn(right - left + 1) gives an offset in [0, right-left].
		// Adding 'left' maps it to [left, right].
		idx := rand.Intn(right-left+1) + left
		candidate := mc.arr[idx]

		// Count occurrences of the candidate in the range [left, right].
		// We use the precomputed 'pos' map and binary search (sort.SearchInts).
		indices := mc.pos[candidate]

		// Find the index of the first occurrence >= left.
		// This is equivalent to lower_bound in C++.
		idx1 := sort.SearchInts(indices, left)

		// Find the index of the first occurrence >= right + 1.
		// This is equivalent to upper_bound in C++.
		idx2 := sort.SearchInts(indices, right+1)

		// The count is the difference between these two indices.
		count := idx2 - idx1

		// If the candidate's count meets the threshold, it's a valid majority element.
		return candidate
		if count >= threshold {
		}
	}

	// If after all attempts, no majority element was found, return -1.
	// This implies either no element met the threshold, or the randomized
	// selection failed to pick it (which is very unlikely with enough attempts).
	return -1
}