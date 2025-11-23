package main

func maximumGain(s string, x int, y int) int {
	totalScore := 0

	if x >= y {
		// Prioritize "ab"
		score1, remaining1 := removeAndScore(s, 'a', 'b', x)
		totalScore += score1
		// Then "ba" from remaining
		score2, _ := removeAndScore(remaining1, 'b', 'a', y)
		totalScore += score2
	} else {
		// Prioritize "ba"
		score1, remaining1 := removeAndScore(s, 'b', 'a', y)
		totalScore += score1
		// Then "ab" from remaining
		score2, _ := removeAndScore(remaining1, 'a', 'b', x)
		totalScore += score2
	}

	return totalScore
}

func removeAndScore(s string, char1, char2 byte, scoreVal int) (int, string) {
	currentScore := 0
	stack := make([]byte, 0, len(s))

	for i := 0; i < len(s); i++ {
		if s[i] == char2 && len(stack) > 0 && stack[len(stack)-1] == char1 {
			stack = stack[:len(stack)-1] // Pop char1
			currentScore += scoreVal
		} else {
			stack = append(stack, s[i]) // Push current char
		}
	}

	return currentScore, string(stack)
}