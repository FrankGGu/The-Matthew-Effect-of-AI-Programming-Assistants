func minTime(time []int, m int) int {
    left, right := 0, 0
    for _, t := range time {
        right += t
    }

    for left < right {
        mid := left + (right-left)/2
        if canComplete(time, m, mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func canComplete(time []int, m, limit int) bool {
    days := 1
    maxTime := 0
    sum := 0
    for _, t := range time {
        if t > maxTime {
            maxTime = t
        }
        sum += t
        if sum - maxTime > limit {
            days++
            sum = t
            maxTime = t
            if days > m {
                return false
            }
        }
    }
    return true
}