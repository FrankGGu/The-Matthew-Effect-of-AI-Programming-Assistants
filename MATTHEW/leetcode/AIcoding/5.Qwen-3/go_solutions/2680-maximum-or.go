package main

func maximumOr(nums []int, k int) int {
    n := len(nums)
    left := make([]int, n)
    right := make([]int, n)

    left[0] = 0
    for i := 1; i < n; i++ {
        left[i] = left[i-1] | nums[i-1]
    }

    right[n-1] = 0
    for i := n - 2; i >= 0; i-- {
        right[i] = right[i+1] | nums[i+1]
    }

    maxOr := 0
    for i := 0; i < n; i++ {
        current := (left[i] | nums[i]) << k
        current |= right[i]
        if current > maxOr {
            maxOr = current
        }
    }

    return maxOr
}