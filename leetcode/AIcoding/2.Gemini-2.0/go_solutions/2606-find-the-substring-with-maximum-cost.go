func maxCost(s string, chars string, costs []int) int {
	costMap := make(map[rune]int)
	for i := 0; i < 26; i++ {
		costMap[rune('a'+i)] = int('a'+i)
	}

	for i := 0; i < len(chars); i++ {
		costMap[rune(chars[i])] = costs[i]
	}

	maxSoFar := 0
	currentMax := 0

	for _, char := range s {
		cost := costMap[char]
		if cost >= 'a' {
			cost = int(char - 'a' + 1)
		}

		currentMax += cost

		if currentMax < 0 {
			currentMax = 0
		}

		if currentMax > maxSoFar {
			maxSoFar = currentMax
		}
	}

	return maxSoFar
}