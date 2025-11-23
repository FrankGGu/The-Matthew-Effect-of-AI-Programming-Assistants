func peakIndexInMountainArray(arr []int) int {
	left, right := 0, len(arr)-1

	for left < right {
		mid := left + (right-left)/2
		if arr[mid] < arr[mid+1] {
			// We are on the increasing slope, peak is to the right
			left = mid + 1
		} else {
			// We are on the decreasing slope or at the peak
			// The peak could be mid, or to its left
			right = mid
		}
	}

	// When the loop terminates, left == right, and this is the peak index.
	return left
}