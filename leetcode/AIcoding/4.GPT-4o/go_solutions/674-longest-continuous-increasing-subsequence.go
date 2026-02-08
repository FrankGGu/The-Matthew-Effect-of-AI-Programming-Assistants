func longestContinuousIncreasingSubsequence(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    maxLength := 1
    currentLength := 1

    for i := 1; i < len(nums); i++ {
        if nums[i] > nums[i-1] {
            currentLength++
        } else {
            if currentLength > maxLength {
                maxLength = currentLength
            }
            currentLength = 1
        }
    }
    if currentLength > maxLength {
        maxLength = currentLength
    }

    return maxLength
}