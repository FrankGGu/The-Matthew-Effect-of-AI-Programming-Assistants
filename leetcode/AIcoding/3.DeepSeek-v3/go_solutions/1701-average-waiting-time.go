func averageWaitingTime(customers [][]int) float64 {
    totalWait := 0
    currentTime := 0
    for _, c := range customers {
        arrival, time := c[0], c[1]
        if currentTime < arrival {
            currentTime = arrival
        }
        totalWait += currentTime + time - arrival
        currentTime += time
    }
    return float64(totalWait) / float64(len(customers))
}