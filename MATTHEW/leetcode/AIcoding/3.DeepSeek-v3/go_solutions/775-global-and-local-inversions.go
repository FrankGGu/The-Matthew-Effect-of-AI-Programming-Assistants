func isIdealPermutation(nums []int) bool {
    n := len(nums)
    for i := 0; i < n; i++ {
        if abs(nums[i]-i) > 1 {
            return false
        }
    }
    return true
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}