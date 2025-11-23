func maximumGain(s string, x int, y int) int {
	ans := 0
	if x > y {
		stack := []rune{}
		for _, c := range s {
			stack = append(stack, c)
			if len(stack) >= 2 && string(stack[len(stack)-2:]) == "ab" {
				ans += x
				stack = stack[:len(stack)-2]
			}
		}
		s = string(stack)
		stack = []rune{}
		for _, c := range s {
			stack = append(stack, c)
			if len(stack) >= 2 && string(stack[len(stack)-2:]) == "ba" {
				ans += y
				stack = stack[:len(stack)-2]
			}
		}
	} else {
		stack := []rune{}
		for _, c := range s {
			stack = append(stack, c)
			if len(stack) >= 2 && string(stack[len(stack)-2:]) == "ba" {
				ans += y
				stack = stack[:len(stack)-2]
			}
		}
		s = string(stack)
		stack = []rune{}
		for _, c := range s {
			stack = append(stack, c)
			if len(stack) >= 2 && string(stack[len(stack)-2:]) == "ab" {
				ans += x
				stack = stack[:len(stack)-2]
			}
		}
	}
	return ans
}