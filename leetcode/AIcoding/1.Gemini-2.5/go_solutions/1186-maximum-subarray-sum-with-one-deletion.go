import "math"

func maximumSum(arr []int) int {
	n := len(arr)

	// maxEndingHereNoDel: maximum subarray sum ending at current position without any deletion.
	// maxEndingHereOneDel: maximum subarray sum ending at current position with one deletion.
	// Initialize maxEndingHereOneDel to a very small number. This state becomes valid
	// when we either extend a previously deleted subarray or delete the current element
	// from a non-deleted subarray. For the first element, deleting it would result
	// in an empty subarray, which is not allowed. So, it's effectively "not possible yet"
	// for the first element.
	maxEndingHereNoDel := arr[0]
	maxEndingHereOneDel := math.MinInt32 / 2 // A sufficiently small number

	overallMax := arr[0]

	for i := 1; i < n; i++ {
		// Calculate maxEndingHereOneDel for current element arr[i]
		// Option 1: Extend the subarray that already had one deletion by adding arr[i].
		// Option 2: Delete arr[i] itself, and take the max sum without deletion ending at arr[i-1].
		maxEndingHereOneDel = max(maxEndingHereOneDel+arr[i], maxEndingHereNoDel)

		// Calculate maxEndingHereNoDel for current element arr[i]
		// Option 1: Start a new subarray with arr[i].
		// Option 2: Extend the previous subarray (without deletion) with arr[i].
		maxEndingHereNoDel = max(arr[i], maxEndingHereNoDel+arr[i])

		// Update overall maximum sum with current states.
		// We need to consider both states for the overall maximum.
		overallMax = max(overallMax, maxEndingHereNoDel, maxEndingHereOneDel)
	}

	return overallMax
}

func max(a int, b ...int) int {
	res := a
	for _, val := range b {
		if val > res {
			res = val
		}
	}
	return res
}