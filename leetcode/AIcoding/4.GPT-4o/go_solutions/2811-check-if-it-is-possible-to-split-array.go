func canSplitArray(nums []int, m int) bool {
    if len(nums) < 2 {
        return true
    }
    for i := 1; i < len(nums); i++ {
        if nums[i-1]+nums[i] > m {
            continue
        }
        if i+1 < len(nums) {
            nums[i] = nums[i-1] + nums[i]
            nums = append(nums[:i-1], nums[i:]...)
            i--
        }
    }
    return true
}