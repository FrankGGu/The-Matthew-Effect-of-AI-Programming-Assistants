func maximumTripletValue(nums []int) int64 {
    n := len(nums)
    maxLeft := make([]int, n)
    maxRight := make([]int, n)

    maxLeft[0] = nums[0]
    for i := 1; i < n; i++ {
        maxLeft[i] = max(maxLeft[i-1], nums[i])
    }

    maxRight[n-1] = nums[n-1]
    for i := n - 2; i >= 0; i-- {
        maxRight[i] = max(maxRight[i+1], nums[i])
    }

    ans := int64(0)
    for j := 1; j < n-1; j++ {
        left := int64(maxLeft[j-1])
        right := int64(maxRight[j+1])
        val := (left - int64(nums[j])) * right
        if val > ans {
            ans = val
        }
    }

    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}