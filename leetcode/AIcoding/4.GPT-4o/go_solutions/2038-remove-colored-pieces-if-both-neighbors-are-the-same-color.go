func removeColoredPieces(colors string, neededTime []int) int {
    totalTime := 0
    maxTime := 0

    for i := 0; i < len(colors); i++ {
        if i > 0 && colors[i] == colors[i-1] {
            totalTime += min(maxTime, neededTime[i])
            maxTime = max(maxTime, neededTime[i])
        } else {
            maxTime = neededTime[i]
        }
    }

    return totalTime
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}