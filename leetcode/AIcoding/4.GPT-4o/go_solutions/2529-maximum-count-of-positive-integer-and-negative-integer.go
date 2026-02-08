func maximumCount(nums []int) int {
    positiveCount, negativeCount := 0, 0
    for _, num := range nums {
        if num > 0 {
            positiveCount++
        } else if num < 0 {
            negativeCount++
        }
    }
    if positiveCount > negativeCount {
        return positiveCount
    }
    return negativeCount
}