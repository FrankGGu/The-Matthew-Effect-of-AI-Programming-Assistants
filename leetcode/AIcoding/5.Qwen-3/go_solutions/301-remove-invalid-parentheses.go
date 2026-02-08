package main

func removeInvalidParentheses(s string) []string {
	var result []string
	visited := make(map[string]bool)
	queue := []string{s}
	visited[s] = true

	found := false

	for len(queue) > 0 {
		size := len(queue)
		for i := 0; i < size; i++ {
			current := queue[0]
			queue = queue[1:]

			if isValid(current) {
				result = append(result, current)
				found = true
			}

			if found {
				continue
			}

			for j := 0; j < len(current); j++ {
				if current[j] != '(' && current[j] != ')' {
					continue
				}

				newStr := current[:j] + current[j+1:]
				if !visited[newStr] {
					visited[newStr] = true
					queue = append(queue, newStr)
				}
			}
		}

		if found {
			break
		}
	}

	return result
}

func isValid(s string) bool {
	count := 0
	for _, c := range s {
		if c == '(' {
			count++
		} else if c == ')' {
			count--
			if count < 0 {
				return false
			}
		}
	}
	return count == 0
}