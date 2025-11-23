func getLastMoment(n int, left []int, right []int) int {
    maxLeft := -1
    maxRight := -1

    for _, ant := range left {
        if ant > maxLeft {
            maxLeft = ant
        }
    }

    for _, ant := range right {
        if ant > maxRight {
            maxRight = ant
        }
    }

    lastMoment := 0
    if maxLeft != -1 {
        lastMoment = n - maxLeft
    }
    if maxRight != -1 {
        if maxRight > lastMoment {
            lastMoment = maxRight
        }
    }

    return lastMoment
}