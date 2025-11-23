func subsetXORSum(nums []int) int {
    total := 0
    n := len(nums)
    subsets := 1 << n
    for i := 0; i < subsets; i++ {
        xorSum := 0
        for j := 0; j < n; j++ {
            if (i & (1 << j)) != 0 {
                xorSum ^= nums[j]
            }
        }
        total += xorSum
    }
    return total
}