package main

import (
	"sort"
)

func minimumTotalCost(nums1 []int, nums2 []int) int64 {
	n := len(nums1)
	var initialCost int64 = 0
	counts := make(map[int]int)
	maxFreq := 0
	maxFreqVal := -1

	// First pass: Calculate initial cost and frequencies of conflicting values.
	// Initial cost is the sum of nums1[i] for all positions i where nums1[i] == nums2[i].
	// This represents the cost of "addressing" each conflict.
	for i := 0; i < n; i++ {
		if nums1[i] == nums2[i] {
			initialCost += int64(nums1[i])
			counts[nums1[i]]++
			if counts[nums1[i]] > maxFreq {
				maxFreq = counts[nums1[i]]
				maxFreqVal = nums1[i]
			}
		}
	}

	// If the most frequent conflicting value (maxFreqVal) does not occur more than n/2 times,
	// then it's always possible to resolve all conflicts by rearranging the conflicting elements
	// among themselves or with non-conflicting elements without incurring additional swap costs.
	// The initialCost is sufficient.
	if maxFreq*2 <= n {
		return initialCost
	}

	// If maxFreq*2 > n, it means there are too many occurrences of maxFreqVal at conflict positions.
	// We need to perform additional swaps to move these 'excess' maxFreqVal instances out of conflict.
	// k is the number of 'excess' maxFreqVal conflicts that cannot be resolved by simple rearrangement.
	// These k maxFreqVal instances must be swapped with elements from non-conflict positions.
	k := maxFreq*2 - n

	var candidateValues []int
	// Second pass: Find suitable elements for swapping with the 'excess' maxFreqVal instances.
	for i := 0; i < n; i++ {
		// A position 'i' (and its value nums1[i]) is a candidate for a swap if:
		// 1. nums1[i] != nums2[i]: It's not a conflict position itself.
		// 2. nums1[i] != maxFreqVal: The value at this position is not the problematic maxFreqVal.
		// 3. maxFreqVal != nums2[i]: Moving maxFreqVal to this position 'i' would not create a new conflict at 'i'.
		if nums1[i] != nums2[i] && nums1[i] != maxFreqVal && maxFreqVal != nums2[i] {
			candidateValues = append(candidateValues, nums1[i])
		}
	}

	// To minimize the additional cost, we sort the candidate values and pick the smallest 'k' of them.
	sort.Ints(candidateValues)

	// If there are not enough suitable positions to swap with, it's impossible.
	if len(candidateValues) < k {
		return -1
	}

	// Add the cost of these 'k' additional swaps.
	// Each swap involves one maxFreqVal and one candidateValue[j], costing maxFreqVal + candidateValue[j].
	for i := 0; i < k; i++ {
		initialCost += int64(maxFreqVal + candidateValues[i])
	}

	return initialCost
}