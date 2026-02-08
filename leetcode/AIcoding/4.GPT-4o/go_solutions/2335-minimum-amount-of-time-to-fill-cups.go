func fillCups(cups []int) int {
    maxTime := 0
    total := 0

    for _, cup := range cups {
        total += cup
        if cup > maxTime {
            maxTime = cup
        }
    }

    return max(maxTime, (total+1)/2)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}