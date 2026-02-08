func maxScore(cardPoints []int, k int) int {
    n := len(cardPoints)
    total := 0
    for i := 0; i < k; i++ {
        total += cardPoints[i]
    }
    maxScore := total

    for i := 0; i < k; i++ {
        total = total - cardPoints[k-1-i] + cardPoints[n-1-i]
        if total > maxScore {
            maxScore = total
        }
    }
    return maxScore
}