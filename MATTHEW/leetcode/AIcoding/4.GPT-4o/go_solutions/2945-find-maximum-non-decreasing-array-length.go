func longestNonDecreasing(nums []int) int {
    maxLength := 1
    currentLength := 1

    for i := 1; i < len(nums); i++ {
        if nums[i] >= nums[i-1] {
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