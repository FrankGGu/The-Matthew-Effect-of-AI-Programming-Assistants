package main

func maxInt(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func minimumLimitOfBallsInABag(nums []int, limit int) int {
    left := 1
    right := 1000000000

    for left < right {
        mid := (left + right) / 2
        count := 0
        for _, num := range nums {
            count += (num + mid - 1) / mid
        }
        if count <= limit {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}