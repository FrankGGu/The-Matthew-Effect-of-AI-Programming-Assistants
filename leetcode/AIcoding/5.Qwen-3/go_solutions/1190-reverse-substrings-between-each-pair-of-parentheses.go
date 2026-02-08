package main

func reverseParentheses(s string) string {
	stack := []string{}
	current := ""
	for _, c := range s {
		if c == '(' {
			stack = append(stack, current)
			current = ""
		} else if c == ')' {
			temp := ""
			for _, ch := range current {
				temp = string(ch) + temp
			}
			current = stack[len(stack)-1] + temp
			stack = stack[:len(stack)-1]
		} else {
			current += string(c)
		}
	}
	return current
}