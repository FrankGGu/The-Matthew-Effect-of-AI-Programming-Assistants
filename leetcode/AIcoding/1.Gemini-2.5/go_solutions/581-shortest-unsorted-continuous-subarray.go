import "math"

func findUnsortedSubarray(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return 0
	}

	// Step 1: Find the left boundary candidate (first element from left that is out of order)
	// Iterate from left to find the first element nums[i] that is greater than nums[i+1].
	// This marks a potential start of the unsorted subarray.
	leftBoundaryCandidate := n
	for i := 0; i < n-1; i++ {
		if nums[i] > nums[i+1] {
			leftBoundaryCandidate = i
			break
		}
	}

	// If no such element is found, the array is already sorted.
	if leftBoundaryCandidate == n {
		return 0
	}

	// Step 2: Find the right boundary candidate (first element from right that is out of order)
	// Iterate from right to find the first element nums[i] that is smaller than nums[i-1].
	// This marks a potential end of the unsorted subarray.
	rightBoundaryCandidate := -1
	for i := n - 1; i > 0; i-- {
		if nums[i] < nums[i-1] {
			rightBoundaryCandidate = i
			break
		}
	}

	// Step 3: Find the minimum and maximum values within the identified unsorted segment
	// This segment is nums[leftBoundaryCandidate ... rightBoundaryCandidate].
	minVal := math.MaxInt32
	maxVal := math.MinInt32
	for i := leftBoundaryCandidate; i <= rightBoundaryCandidate; i++ {
		if nums[i] < minVal {
			minVal = nums[i]
		}
		if nums[i] > maxVal {
			maxVal = nums[i]
		}
	}

	// Step 4: Extend the left boundary to the left
	// The true left boundary is the smallest index `finalLeft` such that `nums[finalLeft]`
	// is greater than `minVal`. This means `nums[finalLeft]` is out of place relative to `minVal`.
	finalLeft := 0
	for finalLeft < n {
		if nums[finalLeft] > minVal {
			break
		}
		finalLeft++
	}

	// Step 5: Extend the right boundary to the right
	// The true right boundary is the largest index `finalRight` such that `nums[finalRight]`
	// is smaller than `maxVal`. This means `nums[finalRight]` is out of place relative to `maxVal`.
	finalRight := n - 1
	for finalRight >= 0 {
		if nums[finalRight] < maxVal {
			break
		}
		finalRight--
	}

	// The length of the shortest unsorted continuous subarray is finalRight - finalLeft + 1.
	return finalRight - finalLeft + 1
}