func lastVisitedIntegers(words []string) []int {
	visited := []int{}
	result := []int{}
	prevCount := 0

	for _, word := range words {
		if word == "prev" {
			prevCount++
			if prevCount > len(visited) {
				result = append(result, -1)
			} else {
				// The prevCount-th last visited integer is at index len(visited) - prevCount
				result = append(result, visited[len(visited)-prevCount])
			}
		} else {
			num, _ := strconv.Atoi(word)
			visited = append(visited, num)
			prevCount = 0 // Reset prevCount when a new integer is encountered
		}
	}

	return result
}