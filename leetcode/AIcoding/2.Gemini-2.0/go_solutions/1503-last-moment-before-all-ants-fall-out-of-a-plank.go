func getLastMoment(n int, left []int, right []int) int {
    maxTime := 0
    for _, pos := range left {
        if pos > maxTime {
            maxTime = pos
        }
    }
    for _, pos := range right {
        time := n - pos
        if time > maxTime {
            maxTime = time
        }
    }
    return maxTime
}