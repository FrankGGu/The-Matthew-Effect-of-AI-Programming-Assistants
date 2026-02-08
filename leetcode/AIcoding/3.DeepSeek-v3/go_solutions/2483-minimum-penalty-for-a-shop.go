func bestClosingTime(customers string) int {
    n := len(customers)
    prefixN := make([]int, n+1)
    suffixY := make([]int, n+1)

    for i := 1; i <= n; i++ {
        if customers[i-1] == 'N' {
            prefixN[i] = prefixN[i-1] + 1
        } else {
            prefixN[i] = prefixN[i-1]
        }
    }

    for i := n - 1; i >= 0; i-- {
        if customers[i] == 'Y' {
            suffixY[i] = suffixY[i+1] + 1
        } else {
            suffixY[i] = suffixY[i+1]
        }
    }

    minPenalty := math.MaxInt32
    bestHour := 0

    for hour := 0; hour <= n; hour++ {
        penalty := prefixN[hour] + suffixY[hour]
        if penalty < minPenalty {
            minPenalty = penalty
            bestHour = hour
        }
    }

    return bestHour
}