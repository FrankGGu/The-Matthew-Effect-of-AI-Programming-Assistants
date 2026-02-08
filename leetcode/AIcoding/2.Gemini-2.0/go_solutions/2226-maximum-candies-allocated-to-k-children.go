func maximumCandies(candies []int, k int) int {
    sum := 0
    for _, c := range candies {
        sum += c
    }
    if sum < k {
        return 0
    }

    left, right := 1, sum/k
    ans := 0
    for left <= right {
        mid := left + (right-left)/2
        count := 0
        for _, c := range candies {
            count += c / mid
        }

        if count >= k {
            ans = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return ans
}