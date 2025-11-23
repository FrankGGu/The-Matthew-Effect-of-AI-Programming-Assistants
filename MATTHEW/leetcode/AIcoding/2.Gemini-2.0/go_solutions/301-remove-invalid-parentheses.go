func removeInvalidParentheses(s string) []string {
	result := make([]string, 0)
	visited := make(map[string]bool)
	queue := []string{s}
	found := false

	for len(queue) > 0 {
		curr := queue[0]
		queue = queue[1:]

		if isValid(curr) {
			result = append(result, curr)
			found = true
		}

		if found {
			continue
		}

		for i := 0; i < len(curr); i++ {
			if curr[i] != '(' && curr[i] != ')' {
				continue
			}

			next := curr[:i] + curr[i+1:]
			if _, ok := visited[next]; !ok {
				visited[next] = true
				queue = append(queue, next)
			}
		}
	}

	return result
}

func isValid(s string) bool {
	count := 0
	for _, char := range s {
		if char == '(' {
			count++
		} else if char == ')' {
			count--
			if count < 0 {
				return false
			}
		}
	}
	return count == 0
}