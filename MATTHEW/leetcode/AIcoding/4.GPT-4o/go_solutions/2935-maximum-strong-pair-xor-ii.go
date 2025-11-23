func maximumStrongPairXOR(nums []int) int {
    n := len(nums)
    maxXOR := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            maxXOR = max(maxXOR, nums[i]^nums[j])
        }
    }
    return maxXOR
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}