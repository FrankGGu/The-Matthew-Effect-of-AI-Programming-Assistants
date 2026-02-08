func averageWaitingTime(customers [][]int) float64 {
    totalWaitTime := 0
    currentTime := 0

    for _, customer := range customers {
        arrivalTime := customer[0]
        eatingTime := customer[1]

        if currentTime < arrivalTime {
            currentTime = arrivalTime
        }
        currentTime += eatingTime
        totalWaitTime += currentTime - arrivalTime
    }

    return float64(totalWaitTime) / float64(len(customers))
}