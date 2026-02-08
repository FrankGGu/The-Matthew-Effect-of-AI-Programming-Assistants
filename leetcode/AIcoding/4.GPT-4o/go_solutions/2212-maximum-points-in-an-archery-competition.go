func maxPoints(numberOfArrows int, arrows []int) []int {
    n := len(arrows)
    maxPoints := make([]int, n)
    bestScore := 0

    for i := 0; i < (1 << n); i++ {
        score := 0
        arrowsUsed := 0
        currentPoints := make([]int, n)

        for j := 0; j < n; j++ {
            if (i>>j)&1 == 1 {
                arrowsUsed += arrows[j] + 1
                score += j
                currentPoints[j] = arrows[j] + 1
            }
        }

        if arrowsUsed <= numberOfArrows && score > bestScore {
            bestScore = score
            maxPoints = currentPoints
        }
    }

    arrowsLeft := numberOfArrows
    for j := 0; j < n; j++ {
        arrowsLeft -= maxPoints[j]
    }

    if arrowsLeft > 0 {
        maxPoints[0] += arrowsLeft
    }

    return maxPoints
}