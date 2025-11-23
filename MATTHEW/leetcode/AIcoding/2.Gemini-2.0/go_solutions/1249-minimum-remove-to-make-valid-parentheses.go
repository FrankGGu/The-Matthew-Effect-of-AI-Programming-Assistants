func minRemoveToMakeValid(s string) string {
	stack := []int{}
	toRemove := make(map[int]bool)

	for i, char := range s {
		if char == '(' {
			stack = append(stack, i)
		} else if char == ')' {
			if len(stack) > 0 {
				stack = stack[:len(stack)-1]
			} else {
				toRemove[i] = true
			}
		}
	}

	for _, i := range stack {
		toRemove[i] = true
	}

	result := ""
	for i, char := range s {
		if _, ok := toRemove[i]; !ok {
			result += string(char)
		}
	}

	return result
}