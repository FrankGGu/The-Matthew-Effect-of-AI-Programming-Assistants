func findSubarrays(nums []int) bool {
    seen := make(map[int]bool)
    for i := 0; i < len(nums)-1; i++ {
        sum := nums[i] + nums[i+1]
        if seen[sum] {
            return true
        }
        seen[sum] = true
    }
    return false
}