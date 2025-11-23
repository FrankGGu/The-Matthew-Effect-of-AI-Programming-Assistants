package main

func longestPushTime(buttonTimes [][]int) int {
    maxTime := 0
    for _, times := range buttonTimes {
        if len(times) < 2 {
            continue
        }
        duration := times[1] - times[0]
        if duration > maxTime {
            maxTime = duration
        }
    }
    return maxTime
}