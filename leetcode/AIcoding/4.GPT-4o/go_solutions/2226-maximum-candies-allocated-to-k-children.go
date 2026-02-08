func maxCandies(candies []int, k int) int {
    left, right := 1, 0
    for _, candy := range candies {
        right += candy
    }

    maxCandies := 0
    for left <= right {
        mid := left + (right-left)/2
        if canDistribute(candies, mid, k) {
            maxCandies = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return maxCandies
}

func canDistribute(candies []int, mid int, k int) bool {
    count := 0
    for _, candy := range candies {
        count += candy / mid
    }
    return count >= k
}