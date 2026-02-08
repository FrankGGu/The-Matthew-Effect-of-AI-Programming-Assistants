func removeDuplicateLetters(s string) string {
	count := make([]int, 26)
	for _, c := range s {
		count[c-'a']++
	}

	stack := []byte{}
	inStack := make([]bool, 26)

	for i := 0; i < len(s); i++ {
		c := s[i]
		count[c-'a']--

		if inStack[c-'a'] {
			continue
		}

		for len(stack) > 0 && c < stack[len(stack)-1] && count[stack[len(stack)-1]-'a'] > 0 {
			inStack[stack[len(stack)-1]-'a'] = false
			stack = stack[:len(stack)-1]
		}

		stack = append(stack, c)
		inStack[c-'a'] = true
	}

	return string(stack)
}