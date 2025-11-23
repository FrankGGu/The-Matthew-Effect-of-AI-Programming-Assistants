func minimizeOR(nums []int, k int) int {
    res := 0
    for i := 0; i < len(nums); i++ {
        if (k & nums[i]) == 0 {
            res |= nums[i]
        }
    }
    return res
}