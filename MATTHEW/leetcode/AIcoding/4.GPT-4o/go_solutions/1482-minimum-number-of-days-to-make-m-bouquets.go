func minDays(bloomDay []int, m int, k int) int {
    if m * k > len(bloomDay) {
        return -1
    }

    left, right := 1, 1
    for _, day := range bloomDay {
        if day > right {
            right = day
        }
    }

    for left < right {
        mid := left + (right-left)/2
        if canMakeBouquets(bloomDay, mid, m, k) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func canMakeBouquets(bloomDay []int, day int, m int, k int) bool {
    count, bouquets := 0, 0
    for _, bd := range bloomDay {
        if bd <= day {
            count++
            if count == k {
                bouquets++
                count = 0
            }
        } else {
            count = 0
        }
    }
    return bouquets >= m
}