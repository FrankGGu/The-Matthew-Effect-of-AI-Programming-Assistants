func rangeSum(nums []int, n int, left int, right int) int {
    mod := int(1e9 + 7)
    sums := make([]int, 0, n*(n+1)/2)

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