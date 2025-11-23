package main

func minPenalty(customers string) int {
    n := len(customers)

    currentPenalty := 0
    for i := 0; i < n; i++ {
        if customers[i] == 'Y' {
            currentPenalty++
        }
    }

    minPenalty := currentPenalty
    minHour := 0

    for j := 1; j <= n; j++ {
        if customers[j-1] == 'Y' {
            currentPenalty--
        } else { // customers[j-1] == 'N'
            currentPenalty++
        }

        if currentPenalty < minPenalty {
            minPenalty = currentPenalty
            minHour = j
        }
    }

    return minHour
}