func findPoisonedDuration(timeSeries []int, duration int) int {
    if len(timeSeries) == 0 {
        return 0
    }
    total := 0
    for i := 1; i < len(timeSeries); i++ {
        diff := timeSeries[i] - timeSeries[i-1]
        if diff < duration {
            total += diff
        } else {
            total += duration
        }
    }
    total += duration
    return total
}