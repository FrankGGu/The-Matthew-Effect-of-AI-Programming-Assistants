func longestUnequalAdjacentGroups(nums []int) int {
    maxLength := 0
    currentLength := 0

    for i := 0; i < len(nums); i++ {
        currentLength++
        if i == len(nums)-1 || nums[i] == nums[i+1] {
            if currentLength > maxLength {
                maxLength = currentLength
            }
            currentLength = 0
        }
    }

    return maxLength
}