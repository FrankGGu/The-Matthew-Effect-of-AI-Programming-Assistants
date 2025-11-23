package main

import (
	"sort"
)

func recoverArray(nums []int) []int {
	sort.Ints(nums)
	N := len(nums)
	n := N / 2

	// Initial frequency map of all numbers in nums
	initialCounts := make(map[int]int)
	for _, num := range nums {
		initialCounts[num]++
	}

	// According to the problem, nums[0] must be x - k for some x in the original array.
	// The corresponding x + k must also be present in nums.
	// Let nums[i] be this x + k.
	// Then, nums[i] - nums[0] = (x + k) - (x - k) = 2k.
	// So, k = (nums[i] - nums[0]) / 2.
	// We iterate through all possible nums[i] (where i > 0) to find candidate k values.
	for i := 1; i < N; i++ {
		diff := nums[i] - nums[0]
		// k must be a positive integer, so diff must be positive and even.
		if diff <= 0 || diff%2 != 0 {
			continue
		}
		k := diff / 2

		// Try to reconstruct the original array 'arr' using this candidate 'k'.
		currentArr := make([]int, 0, n)

		// Create a temporary frequency map for this specific 'k' candidate.
		// This is necessary because map operations modify the counts, and we need to reset
		// for each new 'k' candidate. Copying the map takes O(M) time, where M is the number
		// of distinct elements in nums (at most N).
		tempCounts := make(map[int]int)
		for val, count := range initialCounts {
			tempCounts[val] = count
		}

		isValidK := true
		// Iterate through the sorted 'nums' array.
		// For each number, if it's available, try to pair it up.
		for _, num := range nums {
			if tempCounts[num] == 0 {
				continue // This number has already been used in a pair
			}

			// Assume 'num' is the 'x - k' part of a pair.
			// The corresponding 'x + k' part would be 'num + 2k'.
			targetPlusK := num + 2*k

			if tempCounts[targetPlusK] > 0 {
				// Both 'x - k' and 'x + k' found.
				tempCounts[num]--
				tempCounts[targetPlusK]--
				currentArr = append(currentArr, num+k) // Add 'x' to the original array
			} else {
				// 'x + k' not found for this 'num', so this 'k' is invalid.
				isValidK = false
				break
			}
		}

		// If all numbers were successfully paired up and we formed 'n' elements,
		// this is the unique solution guaranteed by the problem.
		if isValidK && len(currentArr) == n {
			return currentArr
		}
	}

	// The problem guarantees that a unique solution exists, so this line should not be reached.
	return nil
}