func countSubarrays(nums []int, k int64) int64 {
    n := len(nums)
    prefix := make([]int64, n+1)
    for i := 1; i <= n; i++ {
        prefix[i] = prefix[i-1] + int64(nums[i-1])
    }

    var res int64
    left := 0
    for right := 0; right < n; right++ {
        for left <= right && (prefix[right+1]-prefix[left])*int64(right-left+1) >= k {
            left++
        }
        res += int64(right - left + 1)
    }
    return res
}