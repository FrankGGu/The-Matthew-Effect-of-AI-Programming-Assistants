func robotWithString(s string) string {
	n := len(s)
	suffixMin := make([]rune, n+1)
	suffixMin[n] = 'z' + 1
	for i := n - 1; i >= 0; i-- {
		suffixMin[i] = min(rune(s[i]), suffixMin[i+1])
	}

	stack := []rune{}
	result := ""

	for i := 0; i < n; i++ {
		stack = append(stack, rune(s[i]))
		for len(stack) > 0 && stack[len(stack)-1] <= suffixMin[i+1] {
			result += string(stack[len(stack)-1])
			stack = stack[:len(stack)-1]
		}
	}

	for len(stack) > 0 {
		result += string(stack[len(stack)-1])
		stack = stack[:len(stack)-1]
	}

	return result
}

func min(a, b rune) rune {
	if a < b {
		return a
	}
	return b
}