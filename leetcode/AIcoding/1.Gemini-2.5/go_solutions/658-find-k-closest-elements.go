func findClosestElements(arr []int, k int, x int) []int {
	low := 0
	high := len(arr) - k

	for low < high {
		mid := low + (high-low)/2
		if x-arr[mid] <= arr[mid+k]-x {
			high = mid
		} else {
			low = mid + 1
		}
	}
	return arr[low : low+k]
}