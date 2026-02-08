func earliestSecondToMarkIndices(nums []int, changeIndices []int) int {
    n := len(nums)
    m := len(changeIndices)
    left := 1
    right := m
    result := -1

    for left <= right {
        mid := left + (right - left) / 2
        if canMark(nums, changeIndices, mid) {
            result = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    return result
}

func canMark(nums []int, changeIndices []int, s int) bool {
    n := len(nums)
    m := len(changeIndices)
    last := make([]int, n)
    for i := 0; i < n; i++ {
        last[i] = -1
    }

    for i := 0; i < s; i++ {
        idx := changeIndices[i] - 1
        if idx >= 0 && idx < n {
            last[idx] = i
        }
    }

    for i := 0; i < n; i++ {
        if last[i] == -1 {
            return false
        }
    }

    marked := 0
    for i := 0; i < s; i++ {
        idx := changeIndices[i] - 1
        if idx >= 0 && idx < n && last[idx] == i {
            if marked < nums[idx] {
                return false
            }
            marked -= nums[idx]
        } else {
            marked++
        }
    }

    return true
}