func hardestWorker(n int, logs [][]int) int {
    maxDuration := 0
    resultId := logs[0][0] // Initialize with the first employee's ID
    prevFinishTime := 0

    for _, log := range logs {
        id := log[0]
        finishTime := log[1]

        currentDuration := finishTime - prevFinishTime

        if currentDuration > maxDuration {
            maxDuration = currentDuration
            resultId = id
        } else if currentDuration == maxDuration {
            // If durations are equal, choose the employee with the smallest ID
            if id < resultId {
                resultId = id
            }
        }
        prevFinishTime = finishTime
    }

    return resultId
}