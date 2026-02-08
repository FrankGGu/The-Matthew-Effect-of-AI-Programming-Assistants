func maximumOr(nums []int, k int) int {
    n := len(nums)
    maxOr := 0
    prefix := make([]int, n+1)
    suffix := make([]int, n+1)

    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] | nums[i]
    }
    for i := n - 1; i >= 0; i-- {
        suffix[i] = suffix[i+1] | nums[i]
    }

    for i := 0; i < n; i++ {
        maxOr = max(maxOr, prefix[i] | (nums[i]+k) | suffix[i+1])
    }
    return maxOr
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}