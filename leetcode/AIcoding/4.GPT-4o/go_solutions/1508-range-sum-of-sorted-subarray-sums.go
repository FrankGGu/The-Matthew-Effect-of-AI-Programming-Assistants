func rangeSum(nums []int, n int, left int, right int) int {
    mod := 1_000_000_007
    var sums []int
    for i := 0; i < n; i++ {
        currentSum := 0
        for j := i; j < n; j++ {
            currentSum += nums[j]
            sums = append(sums, currentSum)
        }
    }
    sort.Ints(sums)
    result := 0
    for i := left - 1; i < right; i++ {
        result = (result + sums[i]) % mod
    }
    return result
}