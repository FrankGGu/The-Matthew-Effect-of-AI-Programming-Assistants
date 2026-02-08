package main

func averageWaitingTime(customers [][]int) float64 {
    totalWait := 0
    currentTime := 0
    for _, customer := range customers {
        arrival, time := customer[0], customer[1]
        if currentTime < arrival {
            currentTime = arrival
        }
        currentTime += time
        totalWait += currentTime - arrival
    }
    return float64(totalWait) / float64(len(customers))
}