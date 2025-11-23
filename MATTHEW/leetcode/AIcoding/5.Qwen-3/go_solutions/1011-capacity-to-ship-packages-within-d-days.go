package main

func shipWithinDays(weights []int, D int) int {
    left := 0
    right := 0
    for _, w := range weights {
        left = max(left, w)
        right += w
    }

    for left < right {
        mid := (left + right) / 2
        days := 1
        current := 0
        for _, w := range weights {
            if current + w > mid {
                days++
                current = 0
            }
            current += w
        }
        if days > D {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}