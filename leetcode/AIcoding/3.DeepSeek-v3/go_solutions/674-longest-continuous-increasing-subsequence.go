func findLengthOfLCIS(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    maxLen, currentLen := 1, 1
    for i := 1; i < len(nums); i++ {
        if nums[i] > nums[i-1] {
            currentLen++
            if currentLen > maxLen {
                maxLen = currentLen
            }
        } else {
            currentLen = 1
        }
    }
    return maxLen
}