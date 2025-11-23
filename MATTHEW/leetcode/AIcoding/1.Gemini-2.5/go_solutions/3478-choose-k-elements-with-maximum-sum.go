func maxScore(cardPoints []int, k int) int {
    n := len(cardPoints)
    currentSum := 0

    for i := 0; i < k; i++ {
        currentSum += cardPoints[i]
    }

    maxSum := currentSum

    for i := 1; i <= k; i++ {
        currentSum -= cardPoints[k-i]
        currentSum += cardPoints[n-i]
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }

    return maxSum
}