import "sort"

func bagOfTokensScore(tokens []int, power int) int {
	sort.Ints(tokens)
	l, r := 0, len(tokens)-1
	score := 0
	maxScore := 0

	for l <= r {
		if power >= tokens[l] {
			power -= tokens[l]
			score++
			l++
			if score > maxScore {
				maxScore = score
			}
		} else if score > 0 {
			power += tokens[r]
			score--
			r--
		} else {
			break
		}
	}

	return maxScore
}