func findPoisonedDuration(timeSeries []int, duration int) int {
    if len(timeSeries) == 0 {
        return 0
    }

    totalDuration := 0
    for i := 0; i < len(timeSeries)-1; i++ {
        totalDuration += min(duration, timeSeries[i+1]-timeSeries[i])
    }

    // Add the full duration for the last attack
    totalDuration += duration 

    return totalDuration
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}