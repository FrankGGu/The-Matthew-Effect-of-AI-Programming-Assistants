import "sort"

func bagOfTokensScore(tokens []int, P int) int {
    sort.Ints(tokens)
    score, maxScore := 0, 0
    left, right := 0, len(tokens)-1

    for left <= right {
        if P >= tokens[left] {
            P -= tokens[left]
            score++
            maxScore = max(maxScore, score)
            left++
        } else if score > 0 {
            P += tokens[right]
            score--
            right--
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