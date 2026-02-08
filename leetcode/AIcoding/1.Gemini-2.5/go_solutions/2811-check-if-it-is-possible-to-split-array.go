func checkArray(nums []int, m int) bool {
    n := len(nums)
    if n == 1 {
        return true
    }

    for i := 0; i < n; i++ {
        if nums[i] < m {
            return true
        }
    }

    return false
}