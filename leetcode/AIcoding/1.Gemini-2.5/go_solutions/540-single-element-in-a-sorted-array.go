func singleNonDuplicate(nums []int) int {
	low := 0
	high := len(nums) - 1

	for low < high {
		mid := low + (high-low)/2

		// Ensure mid is an even index.
		// If mid is odd, decrement it to make it even.
		if mid%2 == 1 {
			mid--
		}

		// Check if the pair (nums[mid], nums[mid+1]) is a regular pair.
		if nums[mid] == nums[mid+1] {
			// If they are equal, it means this pair is before the single element.
			// The single element must be to the right of this pair.
			// Move 'low' past this pair.
			low = mid + 2
		} else {
			// If they are not equal, it means nums[mid] is either the single element
			// or the single element is to its left.
			// The search space is reduced to [low, mid].
			high = mid
		}
	}

	// When the loop terminates, 'low' and 'high' point to the same index,
	// which is the index of the single non-duplicate element.
	return nums[low]
}