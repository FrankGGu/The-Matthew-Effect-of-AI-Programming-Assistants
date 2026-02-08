package main

func findPoisonedDURATION(timeSeries []int, duration int) int {
    if len(timeSeries) == 0 || duration == 0 {
        return 0
    }
    total := 0
    for i := 1; i < len(timeSeries); i++ {
        if timeSeries[i]-timeSeries[i-1] >= duration {
            total += duration
        } else {
            total += timeSeries[i] - timeSeries[i-1]
        }
    }
    total += duration
    return total
}