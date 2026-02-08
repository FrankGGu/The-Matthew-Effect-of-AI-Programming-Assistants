func countSubarrays(nums []int, k int) int {
    n := len(nums)
    prefixSum := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefixSum[i+1] = prefixSum[i] + nums[i]
    }

    count := 0
    left := 0
    for right := 1; right <= n; right++ {
        for left < right && prefixSum[right]-prefixSum[left] >= k {
            left++
        }
        count += right - left
    }

    return count
}