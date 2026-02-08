func countSubarrays(nums []int, k int) int {
    n := len(nums)
    count := 0
    for i := 0; i < n; i++ {
        sum := 0
        length := 0
        for j := i; j < n; j++ {
            sum += nums[j]
            length++
            if length > 0 && sum*1.0/length >= k {
                count++
            }
        }
    }
    return count
}