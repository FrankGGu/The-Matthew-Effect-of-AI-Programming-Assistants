func countSubarrays(nums []int) int {
    count := 0
    n := len(nums)
    for i := 0; i <= n-3; i++ {
        if nums[i] < nums[i+1] && nums[i+1] < nums[i+2] {
            count++
        }
    }
    return count
}