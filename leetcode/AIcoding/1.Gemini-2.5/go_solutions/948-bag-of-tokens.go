import (
	"sort"
)

func bagOfTokensScore(tokens []int, power int) int {
	sort.Ints(tokens)

	left := 0
	right := len(tokens) - 1
	score := 0
	maxScore := 0

	for left <= right {
		if power >= tokens[left] {
			power -= tokens[left]
			score++
			left++
			if score > maxScore {
				maxScore = score
			}
		} else if score >= 1 && left < right {
			power += tokens[right]
			score--
			right--
		} else {
			break
		}
	}

	return maxScore
}