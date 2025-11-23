func maximumCandies(candies []int, k int64) int {
    left, right := 1, 0
    for _, c := range candies {
        if c > right {
            right = c
        }
    }

    var res int
    for left <= right {
        mid := left + (right - left) / 2
        if canAllocate(candies, k, mid) {
            res = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return res
}

func canAllocate(candies []int, k int64, each int) bool {
    var count int64
    for _, c := range candies {
        count += int64(c / each)
        if count >= k {
            return true
        }
    }
    return false
}