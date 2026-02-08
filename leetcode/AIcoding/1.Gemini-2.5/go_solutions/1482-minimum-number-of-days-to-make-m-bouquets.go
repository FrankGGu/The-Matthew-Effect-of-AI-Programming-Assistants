func minDays(bloomDay []int, m int, k int) int {
    n := len(bloomDay)
    if m*k > n {
        return -1
    }

    low := 1
    high := 0
    for _, day := range bloomDay {
        if day > high {
            high = day
        }
    }

    ans := -1

    for low <= high {
        mid := low + (high-low)/2

        bouquets := 0
        flowers := 0
        for _, day := range bloomDay {
            if day <= mid {
                flowers++
                if flowers == k {
                    bouquets++
                    flowers = 0
                }
            } else {
                flowers = 0
            }
        }

        if bouquets >= m {
            ans = mid
            high = mid - 1
        } else {
            low = mid + 1
        }
    }

    return ans
}