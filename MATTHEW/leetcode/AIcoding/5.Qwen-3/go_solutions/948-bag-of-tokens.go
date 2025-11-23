package main

func bagOfTokens(token []int, power int) int {
    sort.Ints(token)
    left, right := 0, len(token)-1
    maxScore, currentScore := 0, 0
    for left <= right {
        if token[left] <= power {
            power -= token[left]
            left++
            currentScore++
            maxScore = max(maxScore, currentScore)
        } else if currentScore > 0 {
            power += token[right]
            right--
            currentScore--
        } else {
            break
        }
    }
    return maxScore
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}