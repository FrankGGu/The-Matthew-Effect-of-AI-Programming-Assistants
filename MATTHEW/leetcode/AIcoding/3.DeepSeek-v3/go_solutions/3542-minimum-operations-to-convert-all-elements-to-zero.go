func minOperations(nums []int) int {
    res := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] == 0 {
            continue
        }
        if i+1 < len(nums) {
            nums[i+1] ^= nums[i]
        }
        res += nums[i]
    }
    return res
}