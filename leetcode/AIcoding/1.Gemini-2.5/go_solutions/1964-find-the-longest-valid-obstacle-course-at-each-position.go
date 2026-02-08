package main

import (
	"sort"
)

func longestObstacleCourseAtEachPosition(obstacles []int) []int {
	n := len(obstacles)
	ans := make([]int, n)

	// tails[k] stores the smallest ending element of all non-decreasing subsequences of length k+1.
	// The tails array will always be sorted in non-decreasing order.
	tails := []int{}

	for i := 0; i < n; i++ {
		obstacle := obstacles[i]

		// Find the index 'j' where 'obstacle' can be inserted into 'tails'
		// to maintain its non-decreasing order, such that tails[j] is the
		// first element greater than or equal to 'obstacle'.
		// If 'obstacle' is greater than all elements in 'tails', sort.SearchInts returns len(tails).
		j := sort.SearchInts(tails, obstacle)

		if j == len(tails) {
			// If 'j' is equal to the length of 'tails', it means 'obstacle' is
			// greater than or equal to all elements currently in 'tails'.
			// This means 'obstacle' extends the longest non-decreasing subsequence
			// found so far. We append it to 'tails'.
			tails = append(tails, obstacle)
		} else {
			// If 'j' is less than the length of 'tails', it means tails[j] is
			// the first element greater than or equal to 'obstacle'.
			// We can replace tails[j] with 'obstacle'. This forms a non-decreasing
			// subsequence of length 'j+1' ending with 'obstacle', which has a
			// smaller or equal tail than the previous one (tails[j]).
			// This replacement allows for potentially longer subsequences to be formed later.
			tails[j] = obstacle
		}

		// The length of the longest non-decreasing subsequence ending at obstacles[i]
		// is (j + 1) because 'j' is a 0-based index.
		ans[i] = j + 1
	}

	return ans
}