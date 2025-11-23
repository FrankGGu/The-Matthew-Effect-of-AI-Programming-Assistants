func maxScore(cardPoints []int, k int) int {
    n := len(cardPoints)
    total := 0
    for _, point := range cardPoints {
        total += point
    }
    if k == n {
        return total
    }
    windowSize := n - k
    windowSum := 0
    for i := 0; i < windowSize; i++ {
        windowSum += cardPoints[i]
    }
    minSum := windowSum
    for i := windowSize; i < n; i++ {
        windowSum += cardPoints[i] - cardPoints[i-windowSize]
        if windowSum < minSum {
            minSum = windowSum
        }
    }
    return total - minSum
}