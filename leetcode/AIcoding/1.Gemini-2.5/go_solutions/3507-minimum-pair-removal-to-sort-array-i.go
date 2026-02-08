package main

import (
	"sort"
)

func minimumPairRemoval(nums []int) int {
	if len(nums) == 0 {
		return 0
	}

	// 'tails' stores the smallest ending element of all non-decreasing subsequences
	// of a given length. tails[i] is the smallest end element of a subsequence of length i+1.
	tails := make([]int, 0)

	for _, num := range nums {
		// Use binary search to find the insertion point for 'num' in 'tails'.
		// We are looking for the first element in 'tails' that is strictly greater than 'num'.
		// This is equivalent to the 'upper_bound' operation.
		idx := sort.Search(len(tails), func(i int) bool {
			return tails[i] > num
		})

		if idx == len(tails) {
			// If 'num' is greater than or equal to all elements in 'tails',
			// it means we can extend the longest non-decreasing subsequence found so far.
			// So, we append 'num' to 'tails'.
			tails = append(tails, num)
		} else {
			// If 'num' is not greater than all elements, it means we found an element
			// 'tails[idx]' which is strictly greater than 'num'.
			// By replacing 'tails[idx]' with 'num', we are creating a new non-decreasing subsequence
			// of the same length but ending with a smaller element. This new subsequence
			// is more "promising" for future extensions.
			tails[idx] = num
		}
	}

	// The length of 'tails' at the end of the process is the length of the
	// Longest Non-Decreasing Subsequence (LNDS) of the input array.
	// To sort the array, we need to remove all elements that are not part of this LNDS.
	// The minimum number of elements to remove is the total length of the array
	// minus the length of the LNDS.
	return len(nums) - len(tails)
}