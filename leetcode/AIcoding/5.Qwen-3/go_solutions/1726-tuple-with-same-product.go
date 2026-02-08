package main

func sumOfBeauties(nums []int) int {
    n := len(nums)
    minLeft := make([]int, n)
    maxRight := make([]int, n)

    minLeft[0] = nums[0]
    for i := 1; i < n; i++ {
        minLeft[i] = min(minLeft[i-1], nums[i])
    }

    maxRight[n-1] = nums[n-1]
    for i := n - 2; i >= 0; i-- {
        maxRight[i] = max(maxRight[i+1], nums[i])
    }

    res := 0
    for i := 1; i < n-1; i++ {
        if nums[i] > minLeft[i-1] && nums[i] < maxRight[i+1] {
            res++
        }
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}