package main

func removeStars(s string) string {
	var stack []rune
	for _, c := range s {
		if c == '*' {
			if len(stack) > 0 {
				stack = stack[:len(stack)-1]
			}
		} else {
			stack = append(stack, c)
		}
	}
	return string(stack)
}