package main

func maximumTripletValue(nums []int) int {
    n := len(nums)
    maxRight := make([]int, n)
    maxRight[n-1] = nums[n-1]
    for i := n - 2; i >= 0; i-- {
        maxRight[i] = max(nums[i], maxRight[i+1])
    }
    result := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if nums[i] > nums[j] {
                for k := j + 1; k < n; k++ {
                    result = max(result, nums[i]-nums[j]+nums[k])
                }
            }
        }
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}