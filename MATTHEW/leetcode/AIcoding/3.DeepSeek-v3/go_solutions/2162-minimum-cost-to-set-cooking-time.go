func minCostSetTime(startAt int, moveCost int, pushCost int, targetSeconds int) int {
    minCost := math.MaxInt32

    for minutes := 0; minutes <= 99; minutes++ {
        seconds := targetSeconds - minutes*60
        if seconds < 0 || seconds > 99 {
            continue
        }
        digits := make([]int, 0)
        if minutes >= 10 {
            digits = append(digits, minutes/10)
            digits = append(digits, minutes%10)
        } else if minutes > 0 {
            digits = append(digits, minutes)
        } else {
            // minutes is 0, skip leading zeros
        }

        if seconds >= 10 {
            digits = append(digits, seconds/10)
            digits = append(digits, seconds%10)
        } else if len(digits) > 0 || seconds > 0 {
            digits = append(digits, seconds)
        }

        cost := 0
        current := startAt
        for _, digit := range digits {
            if digit != current {
                cost += moveCost
                current = digit
            }
            cost += pushCost
        }
        if cost < minCost {
            minCost = cost
        }
    }

    return minCost
}