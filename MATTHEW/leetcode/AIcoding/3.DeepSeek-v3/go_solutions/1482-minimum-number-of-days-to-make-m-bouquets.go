func minDays(bloomDay []int, m int, k int) int {
    if m*k > len(bloomDay) {
        return -1
    }
    left, right := 1, 0
    for _, day := range bloomDay {
        if day > right {
            right = day
        }
    }

    for left < right {
        mid := left + (right-left)/2
        if canMakeBouquets(bloomDay, m, k, mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func canMakeBouquets(bloomDay []int, m, k, day int) bool {
    bouquets, flowers := 0, 0
    for _, d := range bloomDay {
        if d <= day {
            flowers++
            if flowers == k {
                bouquets++
                flowers = 0
                if bouquets >= m {
                    return true
                }
            }
        } else {
            flowers = 0
        }
    }
    return bouquets >= m
}