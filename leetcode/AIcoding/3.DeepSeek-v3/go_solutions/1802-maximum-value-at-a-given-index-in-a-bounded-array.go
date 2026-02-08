func maxValue(n int, index int, maxSum int) int {
    left, right := 1, maxSum
    result := 0

    for left <= right {
        mid := left + (right - left) / 2
        sum := calculateSum(mid, index, n)
        if sum <= maxSum {
            result = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    return result
}

func calculateSum(mid int, index int, n int) int {
    sum := 0

    left := index
    right := n - index - 1

    sum += mid

    if mid > left {
        sum += (mid - 1 + mid - left) * left / 2
    } else {
        sum += (mid - 1 + 1) * (mid - 1) / 2
        sum += left - (mid - 1)
    }

    if mid > right {
        sum += (mid - 1 + mid - right) * right / 2
    } else {
        sum += (mid - 1 + 1) * (mid - 1) / 2
        sum += right - (mid - 1)
    }

    return sum
}