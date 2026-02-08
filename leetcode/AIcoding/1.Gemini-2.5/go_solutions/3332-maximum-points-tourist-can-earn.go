func maxScoreSightseeingPair(values []int) int {
    maxScore := 0
    maxPrev := values[0] + 0 // Represents max(values[i] + i) for i up to current j-1

    for j := 1; j < len(values); j++ {
        // Calculate score for current j using the best i found so far
        currentScore := maxPrev + values[j] - j
        if currentScore > maxScore {
            maxScore = currentScore
        }

        // Update maxPrev for the next iteration (for j+1)
        // maxPrev should store max(values[k] + k) for k up to current j
        if values[j] + j > maxPrev {
            maxPrev = values[j] + j
        }
    }

    return maxScore
}