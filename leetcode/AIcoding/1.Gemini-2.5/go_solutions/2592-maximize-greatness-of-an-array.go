package main

import "sort"

func maximizeGreatness(nums []int) int {
	sort.Ints(nums)

	p1 := 0 // Pointer for elements to be matched as nums[i] (the smaller element)
	count := 0

	// p2 iterates through the array, looking for elements to be matched as perm[i] (the larger element)
	for p2 := 0; p2 < len(nums); p2++ {
		// If nums[p1] is strictly less than nums[p2], we found a valid pair (nums[p1], nums[p2])
		// where nums[p1] can be permuted to be less than nums[p2].
		if nums[p1] < nums[p2] {
			count++   // Increment the greatness count
			p1++      // Move p1 to the next element, as nums[p1] has been successfully matched
		}
		// If nums[p1] >= nums[p2], nums[p2] cannot be greater than nums[p1].
		// In this case, nums[p2] cannot be used to form a "great" pair with nums[p1].
		// We need to find a larger element for nums[p1], so we simply advance p2
		// to look for the next potential perm[i] element, while p1 stays put.
	}

	return count
}