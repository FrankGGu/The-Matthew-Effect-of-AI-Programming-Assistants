func splitArray(nums []int, m int) int {
    left, right := 0, 0
    for _, num := range nums {
        left = max(left, num)
        right += num
    }

    for left < right {
        mid := left + (right-left)/2
        if canSplit(nums, mid, m) {
            right = mid
        } else {
            left = mid + 1
        }
    }

    return left
}

func canSplit(nums []int, maxSum int, m int) bool {
    count, currentSum := 1, 0
    for _, num := range nums {
        currentSum += num
        if currentSum > maxSum {
            count++
            currentSum = num
            if count > m {
                return false
            }
        }
    }
    return true
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}