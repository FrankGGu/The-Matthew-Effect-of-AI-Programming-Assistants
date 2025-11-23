func findLengthOfLCIS(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    maxLength := 1
    currentLength := 1

    for i := 1; i < n; i++ {
        if nums[i] > nums[i-1] {
            currentLength++
        } else {
            currentLength = 1
        }
        if currentLength > maxLength {
            maxLength = currentLength
        }
    }

    return maxLength
}