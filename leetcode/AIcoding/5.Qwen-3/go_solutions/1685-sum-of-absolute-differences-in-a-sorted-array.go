package main

func sumAbsoluteDifferences(nums []int) []int {
    n := len(nums)
    res := make([]int, n)
    prefix := make([]int, n+1)

    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }

    for i := 0; i < n; i++ {
        left := nums[i]*i - prefix[i]
        right := (prefix[n] - prefix[i+1]) - nums[i]*(n-i-1)
        res[i] = left + right
    }

    return res
}