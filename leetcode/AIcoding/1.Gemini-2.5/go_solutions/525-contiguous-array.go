func findMaxLength(nums []int) int {
    sumMap := make(map[int]int)
    sumMap[0] = -1 

    currentSum := 0
    maxLength := 0

    for i := 0; i < len(nums); i++ {
        if nums[i] == 0 {
            currentSum--
        } else {
            currentSum++
        }

        if prevIndex, found := sumMap[currentSum]; found {
            maxLength = max(maxLength, i - prevIndex)
        } else {
            sumMap[currentSum] = i
        }
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}