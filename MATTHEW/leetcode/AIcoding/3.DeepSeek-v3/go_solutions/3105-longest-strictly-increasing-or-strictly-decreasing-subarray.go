func longestMonotonicSubarray(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    maxLen := 1
    incLen, decLen := 1, 1

    for i := 1; i < len(nums); i++ {
        if nums[i] > nums[i-1] {
            incLen++
            decLen = 1
        } else if nums[i] < nums[i-1] {
            decLen++
            incLen = 1
        } else {
            incLen, decLen = 1, 1
        }
        if incLen > maxLen {
            maxLen = incLen
        }
        if decLen > maxLen {
            maxLen = decLen
        }
    }
    return maxLen
}