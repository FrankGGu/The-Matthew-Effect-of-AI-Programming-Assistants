package main

func slowestKey(keyTimes [][]int) byte {
    maxDuration := 0
    result := 'a'
    prevTime := 0

    for _, kt := range keyTimes {
        duration := kt[1] - prevTime
        if duration > maxDuration || (duration == maxDuration && byte(kt[0]) < result) {
            maxDuration = duration
            result = byte(kt[0])
        }
        prevTime = kt[1]
    }

    return result
}