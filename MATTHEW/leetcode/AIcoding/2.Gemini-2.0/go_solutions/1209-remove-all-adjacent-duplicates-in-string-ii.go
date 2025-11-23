func removeDuplicates(s string, k int) string {
	stack := []struct {
		char  rune
		count int
	}{}

	for _, c := range s {
		if len(stack) > 0 && stack[len(stack)-1].char == c {
			stack[len(stack)-1].count++
			if stack[len(stack)-1].count == k {
				stack = stack[:len(stack)-1]
			}
		} else {
			stack = append(stack, struct {
				char  rune
				count int
			}{char: c, count: 1})
		}
	}

	result := ""
	for _, item := range stack {
		for i := 0; i < item.count; i++ {
			result += string(item.char)
		}
	}

	return result
}