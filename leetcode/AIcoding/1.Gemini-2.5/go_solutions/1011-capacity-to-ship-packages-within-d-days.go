func shipWithinDays(weights []int, D int) int {
    left := 0
    right := 0

    for _, w := range weights {
        if w > left {
            left = w
        }
        right += w
    }

    ans := right

    for left <= right {
        mid := left + (right - left) / 2
        if canShip(mid, weights, D) {
            ans = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return ans
}

func canShip(capacity int, weights []int, D int) bool {
    days := 1
    currentWeight := 0
    for _, w := range weights {
        if currentWeight + w <= capacity {
            currentWeight += w
        } else {
            days++
            currentWeight = w
        }
    }
    return days <= D
}