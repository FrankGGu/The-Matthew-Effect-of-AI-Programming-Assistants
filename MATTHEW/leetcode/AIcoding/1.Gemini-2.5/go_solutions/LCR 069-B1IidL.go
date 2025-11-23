func peakIndexInMountainArray(arr []int) int {
	low := 0
	high := len(arr) - 1

	for low < high {
		mid := low + (high-low)/2
		if arr[mid] < arr[mid+1] {
			// We are on the increasing slope, peak is to the right
			low = mid + 1
		} else {
			// We are on the decreasing slope or at the peak
			// The peak could be mid, or to its left
			high = mid
		}
	}
	return low
}