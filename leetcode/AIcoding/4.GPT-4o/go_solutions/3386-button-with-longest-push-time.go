func longestPushTime(buttons []int) int {
    maxPushTime := 0
    for _, time := range buttons {
        if time > maxPushTime {
            maxPushTime = time
        }
    }
    return maxPushTime
}