func maxRunTime(n int, batteries []int) int64 {
    left, right := int64(1), int64(0)
    for _, b := range batteries {
        right += int64(b)
    }
    right /= int64(n)

    for left <= right {
        mid := left + (right-left)/2
        total := int64(0)
        for _, b := range batteries {
            total += min(int64(b), mid)
        }
        if total >= int64(n)*mid {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return right
}

func min(a, b int64) int64 {
    if a < b {
        return a
    }
    return b
}