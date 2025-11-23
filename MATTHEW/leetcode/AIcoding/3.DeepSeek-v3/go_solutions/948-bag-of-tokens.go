func bagOfTokensScore(tokens []int, power int) int {
    sort.Ints(tokens)
    maxScore, score := 0, 0
    left, right := 0, len(tokens)-1

    for left <= right {
        if power >= tokens[left] {
            power -= tokens[left]
            score++
            left++
            if score > maxScore {
                maxScore = score
            }
        } else if score > 0 {
            power += tokens[right]
            score--
            right--
        } else {
            break
        }
    }

    return maxScore
}