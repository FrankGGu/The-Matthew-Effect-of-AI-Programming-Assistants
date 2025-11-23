package main

import (
	"sort"
)

func maxTheNumber(nums1 []int, nums2 []int, k int) int {
	n := len(nums1)

	// Sort both arrays in ascending order.
	// This is done once outside the binary search.
	// To minimize the sum of x products, we should pick the x smallest elements
	// from nums1 and the x smallest elements from nums2, and then pair them
	// such that a_i * b_i is minimized. The rearrangement inequality states
	// that this sum is minimized when both sequences are sorted in the same order.
	sort.Ints(nums1)
	sort.Ints(nums2)

	// Binary search for the maximum x (number of pairs).
	// x can range from 0 to n.
	low := 0
	high := n + 1 // Exclusive upper bound for x
	ans := 0

	// check function: determines if it's possible to pick 'x' pairs
	// with a total sum of prices less than or equal to 'k'.
	check := func(x int) bool {
		if x == 0 {
			return true // 0 pairs always have a sum of 0, which is <= k.
		}
		if x > n {
			return false // Cannot pick more pairs than available elements.
		}

		var currentCost int64 = 0
		// To minimize the sum for 'x' pairs, we take the first 'x' elements
		// from the sorted nums1 and nums2 arrays and pair them directly.
		for i := 0; i < x; i++ {
			currentCost += int64(nums1[i]) * int64(nums2[i])
			if currentCost > int64(k) { // Early exit if cost exceeds k
				return false
			}
		}
		return true // currentCost <= k
	}

	// Standard binary search template to find the largest 'x' that satisfies check(x).
	for low < high {
		mid := low + (high-low)/2
		if check(mid) {
			ans = mid       // mid is a possible answer, store it.
			low = mid + 1   // Try to find a larger x.
		} else {
			high = mid // mid is too large, try smaller values.
		}
	}

	return ans
}