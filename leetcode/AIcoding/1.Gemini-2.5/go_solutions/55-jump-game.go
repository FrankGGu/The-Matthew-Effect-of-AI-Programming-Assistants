func canJump(nums []int) bool {
    maxReach := 0
    n := len(nums)

    for i := 0; i < n; i++ {
        if i > maxReach {
            return false
        }

        if i + nums[i] > maxReach {
            maxReach = i + nums[i]
        }

        if maxReach >= n - 1 {
            return true
        }
    }

    return false
}