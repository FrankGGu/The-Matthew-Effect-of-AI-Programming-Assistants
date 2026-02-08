func countSubarrays(nums []int, k int) int64 {
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }

    var res int64
    left := 0
    for right := 0; right < n; right++ {
        for left <= right && prefix[right+1]-prefix[left] > k {
            left++
        }
        res += int64(right - left + 1)
    }
    return res
}