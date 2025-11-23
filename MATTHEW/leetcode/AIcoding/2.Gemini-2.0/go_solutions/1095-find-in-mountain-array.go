func findInMountainArray(target int, mountainArr *MountainArray) int {
	n := mountainArr.length()

	peakIndex := findPeakIndex(mountainArr)

	leftResult := binarySearchLeft(mountainArr, target, 0, peakIndex)
	if leftResult != -1 {
		return leftResult
	}

	return binarySearchRight(mountainArr, target, peakIndex+1, n-1)
}

func findPeakIndex(mountainArr *MountainArray) int {
	left, right := 0, mountainArr.length()-1

	for left < right {
		mid := left + (right-left)/2
		if mountainArr.get(mid) < mountainArr.get(mid+1) {
			left = mid + 1
		} else {
			right = mid
		}
	}

	return left
}

func binarySearchLeft(mountainArr *MountainArray, target, left, right int) int {
	for left <= right {
		mid := left + (right-left)/2
		midVal := mountainArr.get(mid)

		if midVal == target {
			return mid
		} else if midVal < target {
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	return -1
}

func binarySearchRight(mountainArr *MountainArray, target, left, right int) int {
	for left <= right {
		mid := left + (right-left)/2
		midVal := mountainArr.get(mid)

		if midVal == target {
			return mid
		} else if midVal < target {
			right = mid - 1
		} else {
			left = mid + 1
		}
	}

	return -1
}