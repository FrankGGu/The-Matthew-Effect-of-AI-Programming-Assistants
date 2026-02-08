func smallestRangeII(nums []int, k int) int {
    sort.Ints(nums)
    n := len(nums)
    res := nums[n-1] - nums[0]

    for i := 0; i < n-1; i++ {
        maxVal := max(nums[i]+k, nums[n-1]-k)
        minVal := min(nums[0]+k, nums[i+1]-k)
        res = min(res, maxVal - minVal)
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}