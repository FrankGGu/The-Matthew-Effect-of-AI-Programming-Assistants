func getMaxLen(nums []int) int {
    maxLen, posLen, negLen := 0, 0, 0

    for _, num := range nums {
        if num > 0 {
            posLen++
            negLen = negLen + 1
        } else if num < 0 {
            posLen, negLen = negLen + 1, posLen + 1
        } else {
            posLen, negLen = 0, 0
        }

        if posLen > maxLen {
            maxLen = posLen
        }
    }

    return maxLen
}