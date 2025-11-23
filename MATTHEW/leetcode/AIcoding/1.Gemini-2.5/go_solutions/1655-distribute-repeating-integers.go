package main

import (
	"sort"
)

type MemoKey struct {
	K      int      // Actual number of distinct item types currently being tracked
	Counts [50]int  // Stores the counts of items. Only the first K elements are relevant and sorted.
}

var memo map[int]map[MemoKey]bool
var quantities []int // Stores the customer quantities, made global for simpler recursion signature

func canDistribute(customerIdx int, itemCounts []int) bool {
	// Base case: If all customers have been satisfied, return true.
	if customerIdx == len(quantities) {
		return true
	}

	// Prepare the memoization key from the current itemCounts.
	// We need to copy and sort itemCounts to ensure a canonical representation for the key.
	var key MemoKey
	key.K = len(itemCounts)
	copy(key.Counts[:key.K], itemCounts)
	sort.Ints(key.Counts[:key.K]) // Sort only the relevant part of the array

	// Check if this state has been computed before.
	if _, ok := memo[customerIdx]; ok {
		if val, ok := memo[customerIdx][key]; ok {
			return val
		}
	}

	q := quantities[customerIdx] // The quantity of items the current customer wants

	// Optimization: To avoid redundant computations when multiple item types have the same count,
	// we only attempt to use an item type with a specific count value once for the current customer.
	seenCounts := make(map[int]bool)

	// Iterate through each distinct item type available.
	for i := 0; i < len(itemCounts); i++ {
		// If the current item type has enough items for the customer.
		if itemCounts[i] >= q {
			// Check if we've already tried assigning from an item type with this specific count value.
			if !seenCounts[itemCounts[i]] {
				seenCounts[itemCounts[i]] = true // Mark this count value as seen for this customerIdx

				// Try assigning items: temporarily reduce the count for this item type.
				itemCounts[i] -= q

				// Recursively try to satisfy the next customer.
				if canDistribute(customerIdx+1, itemCounts) {
					// If successful, memoize true for the current state and return true.
					if memo[customerIdx] == nil {
						memo[customerIdx] = make(map[MemoKey]bool)
					}
					memo[customerIdx][key] = true
					return true
				}

				// Backtrack: restore the count for this item type for other possibilities.
				itemCounts[i] += q
			}
		}
	}

	// If no item type could satisfy the current customer, memoize false for this state.
	if memo[customerIdx] == nil {
		memo[customerIdx] = make(map[MemoKey]bool)
	}
	memo[customerIdx][key] = false
	return false
}

func distributeRepeatingIntegers(nums []int, quantity []int) bool {
	// 1. Count the frequency of each distinct item type in nums.
	freqMap := make(map[int]int)
	for _, num := range nums {
		freqMap[num]++
	}

	// 2. Extract these frequencies (item counts) into a slice.
	// This slice represents the available item types and their current counts.
	itemCounts := make([]int, 0, len(freqMap))
	for _, count := range freqMap {
		itemCounts = append(itemCounts, count)
	}

	// 3. Sort the customer quantities in descending order.
	// This is a common optimization for backtracking problems, as it tends to prune
	// the search space faster by trying to satisfy larger requests first.
	sort.Sort(sort.Reverse(sort.IntSlice(quantity)))
	quantities = quantity // Assign to the global variable for use in recursion

	// 4. Initialize the memoization table.
	memo = make(map[int]map[MemoKey]bool)

	// 5. Start the backtracking process from the first customer (index 0).
	return canDistribute(0, itemCounts)
}