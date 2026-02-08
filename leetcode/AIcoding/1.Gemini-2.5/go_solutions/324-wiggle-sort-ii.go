package main

import (
	"sort"
)

func wiggleSort(nums []int) {
	n := len(nums)
	if n <= 1 {
		return
	}

	// Create a copy of the array and sort it.
	// This takes O(N log N) time and O(N) space.
	arr := make([]int, n)
	copy(arr, nums)
	sort.Ints(arr)

	// Initialize pointers for the sorted array.
	// `smallPtr` points to the last element of the smaller half.
	// `largePtr` points to the last element of the larger half.
	smallPtr := (n - 1) / 2
	largePtr := n - 1

	// Fill the original `nums` array from left to right.
	// Odd indices (1, 3, 5, ...) are filled with larger elements.
	// Even indices (0, 2, 4, ...) are filled with smaller elements.
	// By taking elements from the end of each half (i.e., largest of smaller half, largest of larger half),
	// we ensure maximum separation between potentially equal elements, which helps satisfy the wiggle condition.
	for i := 0; i < n; i++ {
		if i%2 == 1 { // Odd index, place a larger element
			nums[i] = arr[largePtr]
			largePtr--
		} else { // Even index, place a smaller element
			nums[i] = arr[smallPtr]
			smallPtr--
		}
	}
}