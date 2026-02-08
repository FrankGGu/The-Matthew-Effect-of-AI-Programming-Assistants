func countBadPairs(nums []int) int64 {
    n := len(nums)
    goodPairs := 0
    for i := 0; i < n; i++ {
        goodPairs += i - nums[i]
    }
    totalPairs := n * (n - 1) / 2
    return int64(totalPairs - goodPairs)
}