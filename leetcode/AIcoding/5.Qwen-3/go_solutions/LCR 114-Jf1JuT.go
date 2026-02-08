package main

func alienOrder(words []string) string {
	if len(words) == 0 {
		return ""
	}

	// Build graph and in-degree map
	graph := make(map[rune][]rune)
	inDegree := make(map[rune]int)

	// Add all unique characters to graph and in-degree
	for _, word := range words {
		for _, ch := range word {
			if _, exists := graph[ch]; !exists {
				graph[ch] = []rune{}
				inDegree[ch] = 0
			}
		}
	}

	// Build edges from adjacent words
	for i := 0; i < len(words)-1; i++ {
		word1 := words[i]
		word2 := words[i+1]

		minLen := min(len(word1), len(word2))
		for j := 0; j < minLen; j++ {
			ch1 := rune(word1[j])
			ch2 := rune(word2[j])
			if ch1 != ch2 {
				// Add edge ch1 -> ch2
				if !contains(graph[ch1], ch2) {
					graph[ch1] = append(graph[ch1], ch2)
					inDegree[ch2]++
				}
				break
			}
		}
	}

	// Topological sort using Kahn's algorithm
	queue := []rune{}
	for ch, degree := range inDegree {
		if degree == 0 {
			queue = append(queue, ch)
		}
	}

	result := []rune{}
	for len(queue) > 0 {
		ch := queue[0]
		queue = queue[1:]
		result = append(result, ch)

		for _, neighbor := range graph[ch] {
			inDegree[neighbor]--
			if inDegree[neighbor] == 0 {
				queue = append(queue, neighbor)
			}
		}
	}

	// Check if all characters are included (no cycles)
	if len(result) != len(inDegree) {
		return ""
	}

	return string(result)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func contains(list []rune, ch rune) bool {
	for _, c := range list {
		if c == ch {
			return true
		}
	}
	return false
}