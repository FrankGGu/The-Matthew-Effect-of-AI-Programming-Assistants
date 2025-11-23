package main

func maxScore(cardPoints []int, k int) int {
    n := len(cardPoints)
    total := 0
    for _, v := range cardPoints {
        total += v
    }

    windowSize := n - k
    current := 0
    for i := 0; i < windowSize; i++ {
        current += cardPoints[i]
    }

    minWindow := current
    for i := windowSize; i < n; i++ {
        current += cardPoints[i] - cardPoints[i-windowSize]
        if current < minWindow {
            minWindow = current
        }
    }

    return total - minWindow
}