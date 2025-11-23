func maxSubArray(nums []int) int {
    maxCurrent, maxGlobal := nums[0], nums[0]
    for i := 1; i < len(nums); i++ {
        if nums[i] > maxCurrent + nums[i] {
            maxCurrent = nums[i]
        } else {
            maxCurrent += nums[i]
        }
        if maxCurrent > maxGlobal {
            maxGlobal = maxCurrent
        }
    }
    return maxGlobal
}