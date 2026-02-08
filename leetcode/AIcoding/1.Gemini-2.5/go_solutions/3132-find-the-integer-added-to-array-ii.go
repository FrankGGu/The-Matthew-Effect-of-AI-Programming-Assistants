import (
	"math"
	"sort"
)

func minimumAddedInteger(nums1 []int, nums2 []int) int {
	sort.Ints(nums1)
	sort.Ints(nums2)

	n := len(nums1)
	minX := math.MaxInt // Initialize with a very large value

	// We consider 3 possible scenarios for the first element of nums2 (nums2[0]):
	// It could correspond to nums1[0], nums1[1], or nums1[2] after two elements are removed.
	// This covers all cases for the smallest element in the remaining nums1 subarray.
	// If nums2[0] corresponds to nums1[k], then x = nums2[0] - nums1[k].
	for k := 0; k < 3; k++ {
		candidateX := nums2[0] - nums1[k]
		if candidateX < 0 {
			// x must be non-negative.
			// Since nums1 and nums2 are sorted, if nums2[0] - nums1[k] is negative,
			// any further nums1[j] (j > k) would be greater than or equal to nums1[k],
			// leading to an even smaller (more negative) x.
			// So, if nums2[0] - nums1[k] is negative, no valid non-negative x can be found
			// by matching nums2[0] with nums1[k] or any subsequent element.
			continue
		}

		// Check if this candidateX is valid
		if isValid(candidateX, nums1, nums2) {
			if candidateX < minX {
				minX = candidateX
			}
		}
	}

	return minX
}

func isValid(x int, nums1 []int, nums2 []int) bool {
	n1Len := len(nums1)
	n2Len := len(nums2)

	removedCount := 0
	ptr1 := 0 // pointer for nums1
	ptr2 := 0 // pointer for nums2

	for ptr2 < n2Len {
		// If we run out of elements in nums1 before matching all of nums2
		if ptr1 >= n1Len {
			return false
		}

		expectedN1Val := nums2[ptr2] - x

		// Skip elements in nums1 that are smaller than expectedN1Val.
		// These must be among the two removed elements.
		for ptr1 < n1Len && nums1[ptr1] < expectedN1Val {
			removedCount++
			ptr1++
			if removedCount > 2 {
				return false // More than 2 elements removed
			}
		}

		// If we ran out of nums1 elements, or the current nums1[ptr1] is too large,
		// then expectedN1Val cannot be found.
		if ptr1 >= n1Len || nums1[ptr1] > expectedN1Val {
			return false
		}

		// Match found: nums1[ptr1] == expectedN1Val
		ptr1++
		ptr2++
	}

	// After matching all elements of nums2, count any remaining elements in nums1 as removed.
	removedCount += (n1Len - ptr1)

	return removedCount == 2
}