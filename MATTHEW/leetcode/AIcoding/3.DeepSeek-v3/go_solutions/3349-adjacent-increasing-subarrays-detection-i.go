func canSplitArray(nums []int) bool {
    n := len(nums)
    if n <= 2 {
        return true
    }
    for i := 1; i < n; i++ {
        if nums[i-1] + nums[i] >= 100 {
            return true
        }
    }
    return false
}