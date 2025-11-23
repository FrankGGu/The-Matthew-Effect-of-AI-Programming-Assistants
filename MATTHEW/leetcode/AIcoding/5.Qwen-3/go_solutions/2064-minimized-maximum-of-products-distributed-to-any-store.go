package main

func splitArray(nums []int, m int) int {
    left := 0
    right := 0
    for _, num := range nums {
        left = max(left, num)
        right += num
    }

    for left < right {
        mid := (left + right) / 2
        count := 1
        currentSum := 0

        for _, num := range nums {
            if currentSum+num > mid {
                count++
                currentSum = num
            } else {
                currentSum += num
            }
        }

        if count <= m {
            right = mid
        } else {
            left = mid + 1
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