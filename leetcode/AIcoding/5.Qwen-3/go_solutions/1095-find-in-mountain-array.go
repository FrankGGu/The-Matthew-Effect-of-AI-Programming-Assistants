package main


type MountainArray interface {
	Get(index int) int
}

func findInMountainArray(target int, mountainArr MountainArray) int {
	// Find the peak index
	left, right := 0, 0
	for mountainArr.Get(right) < mountainArr.Get(right+1) {
		right++
	}
	peak := right

	// Binary search on the ascending part
	left, right = 0, peak
	for left <= right {
		mid := left + (right-left)/2
		val := mountainArr.Get(mid)
		if val == target {
			return mid
		} else if val < target {
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	// Binary search on the descending part
	left, right = peak, 0
	for left >= right {
		mid := left - (left-right)/2
		val := mountainArr.Get(mid)
		if val == target {
			return mid
		} else if val < target {
			left = mid - 1
		} else {
			right = mid + 1
		}
	}

	return -1
}