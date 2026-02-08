func splitArray(nums []int, m int) int {
    left, right := 0, 0
    for _, num := range nums {
        if num > left {
            left = num
        }
        right += num
    }

    for left < right {
        mid := left + (right - left) / 2
        if canSplit(nums, m, mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func canSplit(nums []int, m int, maxSum int) bool {
    sum, count := 0, 1
    for _, num := range nums {
        sum += num
        if sum > maxSum {
            sum = num
            count++
            if count > m {
                return false
            }
        }
    }
    return true
}