func smallestSubsequence(s string, k int, letter byte, repetition int) string {
	n := len(s)
	count := 0
	for i := 0; i < n; i++ {
		if s[i] == letter {
			count++
		}
	}

	stack := []byte{}
	for i := 0; i < n; i++ {
		for len(stack) > 0 && s[i] < stack[len(stack)-1] &&
			(n-i+len(stack) > k) &&
			(stack[len(stack)-1] != letter || count > repetition) {
			if stack[len(stack)-1] == letter {
				repetition--
			}
			stack = stack[:len(stack)-1]
		}

		if len(stack) < k {
			if s[i] == letter {
				stack = append(stack, s[i])
				repetition--
			} else if k-len(stack) > repetition {
				stack = append(stack, s[i])
			}
		}

		if s[i] == letter {
			count--
		}
	}

	return string(stack)
}