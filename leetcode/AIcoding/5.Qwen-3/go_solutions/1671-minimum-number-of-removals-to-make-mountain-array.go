package main

func minimumRemovals(nums []int) int {
    n := len(nums)
    left := make([]int, n)
    right := make([]int, n)

    for i := 0; i < n; i++ {
        for j := 0; j < i; j++ {
            if nums[j] < nums[i] {
                left[i] = max(left[i], left[j]+1)
            }
        }
    }

    for i := n - 1; i >= 0; i-- {
        for j := n - 1; j > i; j-- {
            if nums[j] < nums[i] {
                right[i] = max(right[i], right[j]+1)
            }
        }
    }

    result := 0
    for i := 0; i < n; i++ {
        if left[i] > 0 && right[i] > 0 {
            result = max(result, left[i]+right[i]+1)
        }
    }

    return n - result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}