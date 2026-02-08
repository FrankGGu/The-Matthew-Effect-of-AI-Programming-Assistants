func findPoisonedDuration(timeSeries []int, duration int) int {
    if len(timeSeries) == 0 {
        return 0
    }
    total := 0
    for i := 1; i < len(timeSeries); i++ {
        if timeSeries[i] < timeSeries[i-1]+duration {
            total += timeSeries[i] - timeSeries[i-1]
        } else {
            total += duration
        }
    }
    total += duration
    return total
}