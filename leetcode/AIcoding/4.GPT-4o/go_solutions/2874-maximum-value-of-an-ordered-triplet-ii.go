func maximumTripletValue(nums []int) int {
    n := len(nums)
    maxValue := 0
    maxPrefix := make([]int, n)
    maxPrefix[0] = nums[0]

    for i := 1; i < n; i++ {
        maxPrefix[i] = max(maxPrefix[i-1], nums[i])
    }

    for j := 1; j < n-1; j++ {
        maxValue = max(maxValue, maxPrefix[j-1]-nums[j]+nums[j+1])
    }

    return maxValue
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}