func maxValue(n int, index int, maxSum int) int {
    left := index
    right := n - index - 1
    low, high := 1, maxSum

    for low < high {
        mid := (low + high + 1) / 2
        total := mid + sum(left, mid) + sum(right, mid)
        if total <= maxSum {
            low = mid
        } else {
            high = mid - 1
        }
    }
    return low
}

func sum(length, value int) int {
    if length <= value {
        return (length * (value + value - length + 1)) / 2
    }
    return (value * (value + 1)) / 2 + (length - value)
}