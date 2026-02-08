package main

func maximumCandies(candies []int, k int) int {
    left, right := 0, len(candies)
    var ans int

    for left <= right {
        mid := left + (right-left)/2
        count := 0
        for _, c := range candies {
            count += c / mid
            if count >= k {
                break
            }
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