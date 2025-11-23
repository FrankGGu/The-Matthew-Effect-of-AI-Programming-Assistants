func earliestSecondToMarkIndices(nums []int, changeIndices []int) int {
    n := len(nums)
    m := len(changeIndices)
    left, right := 1, m
    result := -1

    for left <= right {
        mid := left + (right-left)/2
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
    last := make([]int, n+1)
    for i := 0; i < s; i++ {
        idx := changeIndices[i]
        last[idx] = i + 1
    }

    for i := 1; i <= n; i++ {
        if last[i] == 0 {
            return false
        }
    }

    marked := 0
    for i := 0; i < s; i++ {
        idx := changeIndices[i]
        if last[idx] == i+1 {
            if marked < nums[idx-1] {
                return false
            }
            marked -= nums[idx-1]
        } else {
            marked++
        }
    }

    return true
}