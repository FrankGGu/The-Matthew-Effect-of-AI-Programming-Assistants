func maxScore(cardPoints []int, k int) int {
    n := len(cardPoints)

    // Calculate the total sum of all card points
    totalSum := 0
    for _, point := range cardPoints {
        totalSum += point
    }

    // If k is equal to the number of cards, we take