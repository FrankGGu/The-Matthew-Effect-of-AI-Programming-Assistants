func getLastMoment(n int, left []int, right []int) int {
    maxTime := 0

    // For ants moving left, the time it takes to fall off is their current position.
    // The ant that takes the longest to fall off will be the one furthest to the right.
    for _, pos := range left {
        if pos > maxTime {
            maxTime = pos
        }
    }

    // For ants moving right, the time it takes to fall off is n - their current position.
    // The ant that takes the longest to fall off will be the one furthest to the left.
    for _, pos := range right {
        if n - pos > maxTime {
            maxTime = n - pos
        }
    }

    return maxTime
}