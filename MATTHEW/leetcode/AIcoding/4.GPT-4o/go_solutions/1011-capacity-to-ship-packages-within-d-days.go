func shipWithinDays(weights []int, D int) int {
    left, right := 0, 0
    for _, weight := range weights {
        left = max(left, weight)
        right += weight
    }

    for left < right {
        mid := left + (right-left)/2
        if canShip(weights, D, mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func canShip(weights []int, D int, capacity int) bool {
    days := 1
    currentWeight := 0

    for _, weight := range weights {
        currentWeight += weight
        if currentWeight > capacity {
            days++
            currentWeight = weight
        }
    }
    return days <= D
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}