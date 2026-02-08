/**
 * // This is the MountainArray's API interface.
 * // You should not implement it, or speculate about its implementation
 * type MountainArray struct {
 * }
 *
 * func (this *MountainArray) get(index int) int {}
 * func (this *MountainArray) length() int {}
 */

func findInMountainArray(target int, mountainArr *MountainArray) int {
    n := mountainArr.length()
    left, right := 0, n-1

    peak := findPeak(mountainArr, n)

    res := binarySearch(mountainArr, target, 0, peak, true)
    if res != -1 {
        return res
    }
    return binarySearch(mountainArr, target, peak+1, n-1, false)
}

func findPeak(mountainArr *MountainArray, n int) int {
    left, right := 0, n-1
    for left < right {
        mid := left + (right - left) / 2
        if mountainArr.get(mid) < mountainArr.get(mid+1) {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}

func binarySearch(mountainArr *MountainArray, target, left, right int, asc bool) int {
    for left <= right {
        mid := left + (right - left) / 2
        val := mountainArr.get(mid)
        if val == target {
            return mid
        }
        if asc {
            if val < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        } else {
            if val > target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
    return -1
}