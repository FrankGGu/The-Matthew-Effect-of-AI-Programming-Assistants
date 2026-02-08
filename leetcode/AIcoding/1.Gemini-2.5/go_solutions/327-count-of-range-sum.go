func countRangeSum(nums []int, lower int, upper int) int {
    n := len(nums)
    prefixSums := make([]int64, n+1)
    for i := 0; i < n; i++ {
        prefixSums[i+1] = prefixSums[i] + int6