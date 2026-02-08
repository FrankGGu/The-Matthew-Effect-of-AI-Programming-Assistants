func longestAlternatingSubarray(nums []int) int {
    maxLength := 0
    currentLength := 1

    for i := 1; i < len(nums); i++ {
        if (nums[i] > nums[i-1] && (i%2 == 1)) || (nums[i] < nums[i-1] && (i%2 == 0)) {
            currentLength++
        } else {
            maxLength = max(maxLength, currentLength)
            currentLength = 1
        }
    }

    maxLength = max(maxLength, currentLength)
    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}