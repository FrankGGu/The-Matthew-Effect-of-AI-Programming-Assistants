func findInMountainArray(target int, mountainArr MountainArray) int {
    n := mountainArr.Length()

    // Find the peak of the mountain
    left, right := 0, n-1
    peak := 0
    for left < right {
        mid := left + (right-left)/2
        if mountainArr.Get(mid) < mountainArr.Get(mid+1) {
            left = mid + 1
        } else {
            right = mid
        }
    }
    peak = left

    // Search in the increasing part
    index := binarySearch(mountainArr, target, 0, peak, true)
    if index != -1 {
        return index
    }

    // Search in the decreasing part
    return binarySearch(mountainArr, target, peak+1, n-1, false)
}

func binarySearch(mountainArr MountainArray, target, left, right int, increasing bool) int {
    for left <= right {
        mid := left + (right-left)/2
        midVal := mountainArr.Get(mid)

        if midVal == target {
            return mid
        }

        if (increasing && midVal < target) || (!increasing && midVal > target) {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return -1
}