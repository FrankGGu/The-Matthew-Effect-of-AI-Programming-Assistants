func findMaxConsecutiveOnes(nums []int) int {
    maxCount := 0
    currentCount := 0
    for _, num := range nums {
        if num == 1 {
            currentCount++
        } else {
            if currentCount > maxCount {
                maxCount = currentCount
            }
            currentCount = 0
        }
    }
    if currentCount > maxCount {
        maxCount = currentCount
    }
    return maxCount
}