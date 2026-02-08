func hardestWorker(n int, logs [][]int) int {
    maxTime := logs[0][1]
    result := logs[0][0]

    for i := 1; i < len(logs); i++ {
        currentTime := logs[i][1] - logs[i-1][1]
        if currentTime > maxTime {
            maxTime = currentTime
            result = logs[i][0]
        } else if currentTime == maxTime {
            if logs[i][0] < result {
                result = logs[i][0]
            }
        }
    }

    return result
}