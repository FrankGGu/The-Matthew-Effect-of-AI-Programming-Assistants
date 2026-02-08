func getMaxLen(nums []int) int {
    maxLen, posLen, negLen := 0, 0, 0
    for _, num := range nums {
        if num == 0 {
            posLen, negLen = 0, 0
        } else if num > 0 {
            posLen++
            if negLen > 0 {
                negLen++
            }
            if posLen > maxLen {
                maxLen = posLen
            }
        } else {
            posLen, negLen = negLen, posLen
            negLen++
            if posLen > 0 {
                posLen++
            }
            if posLen > maxLen {
                maxLen = posLen
            }
        }
    }
    return maxLen
}