func getAverages(nums []int, k int) []int {
    n := len(nums)
    result := make([]int, n)
    for i := range result {
        result[i] = -1
    }

    if n < 2*k+1 {
        return result
    }

    windowSum := 0
    for i := 0; i < 2*k+1; i++ {
        windowSum += nums[i]
    }

    result[k] = windowSum / (2*k + 1)

    for i := k + 1; i <= n-k-1; i++ {
        windowSum += nums[i+k] - nums[i-k-1]
        result[i] = windowSum / (2*k + 1)
    }

    return result
}