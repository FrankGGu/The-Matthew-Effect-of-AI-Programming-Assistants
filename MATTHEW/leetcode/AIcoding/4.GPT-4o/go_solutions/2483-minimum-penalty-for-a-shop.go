func bestClosingTime(customers string) int {
    n := len(customers)
    penalty := 0
    for _, c := range customers {
        if c == 'N' {
            penalty++
        }
    }

    minPenalty := penalty
    bestTime := 0

    for i := 0; i < n; i++ {
        if customers[i] == 'Y' {
            penalty--
        } else {
            penalty++
        }

        if penalty < minPenalty {
            minPenalty = penalty
            bestTime = i + 1
        }
    }

    return bestTime
}