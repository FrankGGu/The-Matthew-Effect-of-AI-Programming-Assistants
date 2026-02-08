package main

func countBadPairs(nums []int) int64 {
	n := len(nums)

	// Total possible pairs (i, j) where i < j
	// This is the sum of integers from 1 to n-1, or n * (n - 1) / 2
	totalPairs := int64(n) * int64(n-1) / 2

	// We want to count "bad pairs": (i, j) such that i < j and nums[i] + i != nums[j] + j.
	// It's easier to count "good pairs": (i, j) such that i < j and nums[i] + i == nums[j] + j.
	// Then, bad pairs = total pairs - good pairs.

	// Let val[k] = nums[k] + k.
	// A good pair (i, j) means i < j and val[i] == val[j].

	// Use a frequency map to store counts of val[k] encountered so far.
	counts := make(map[int]int)
	var goodPairs int64 = 0

	for i := 0; i < n; i++ {
		// Calculate val for the current index i
		currentVal := nums[i] + i

		// If currentVal has been seen before, each previous occurrence of currentVal
		// forms a "good pair" with the current element at index i.
		// The number of such previous occurrences is counts[currentVal].
		goodPairs += int64(counts[currentVal])

		// Increment the count for the currentVal, so it can form good pairs with future elements.
		counts[currentVal]++
	}

	// The number of bad pairs is the total possible pairs minus the good pairs.
	return totalPairs - goodPairs
}