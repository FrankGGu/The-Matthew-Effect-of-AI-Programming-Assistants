func extractMantra(actions []string) string {
	stack := []string{}
	result := ""
	for _, action := range actions {
		if action == "undo" {
			if len(stack) > 0 {
				stack = stack[:len(stack)-1]
			}
		} else {
			stack = append(stack, action)
		}
	}
	for _, s := range stack {
		result += s
	}
	return result
}