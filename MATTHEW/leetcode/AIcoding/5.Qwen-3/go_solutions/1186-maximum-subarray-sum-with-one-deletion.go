package main

func maximumSubarraySum(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    dpNoDelete := make([]int, n)
    dpWithDelete := make([]int, n)

    dpNoDelete[0] = nums[0]
    dpWithDelete[0] = -1 << 63

    for i := 1; i < n; i++ {
        dpNoDelete[i] = max(dpNoDelete[i-1]+nums[i], nums[i])
        dpWithDelete[i] = max(dpWithDelete[i-1]+nums[i], dpNoDelete[i-1])
    }

    result := dpNoDelete[0]
    for i := 1; i < n; i++ {
        result = max(result, dpNoDelete[i], dpWithDelete[i])
    }

    return result
}

func max(a ...int) int {
    m := a[0]
    for _, v := range a[1:] {
        if v > m {
            m = v
        }
    }
    return m
}