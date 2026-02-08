func canReachZero(nums []int) bool {
    n := len(nums)
    if n == 0 {
        return true
    }

    for i := 0; i < n; i++ {
        if nums[i] < 0 {
            return false
        }
        if nums[