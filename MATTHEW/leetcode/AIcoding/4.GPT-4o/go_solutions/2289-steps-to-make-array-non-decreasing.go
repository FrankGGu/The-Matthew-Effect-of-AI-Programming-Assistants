func minimizeArray(nums []int) int {
    steps := 0
    for i := len(nums) - 1; i > 0; i-- {
        if nums[i] < nums[i-1] {
            diff := nums[i-1] - nums[i]
            steps += diff
            nums[i-1] -= diff
        }
    }
    return steps
}