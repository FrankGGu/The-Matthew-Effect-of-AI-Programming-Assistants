package main

func parseBoolExpr(s string) bool {
	var stack []rune
	for _, c := range s {
		if c == '(' || c == 't' || c == 'f' || c == '!' || c == '&' || c == '|' {
			stack = append(stack, c)
		} else if c == ')' {
			var expr []rune
			for stack[len(stack)-1] != '(' {
				expr = append(expr, stack[len(stack)-1])
				stack = stack[:len(stack)-1]
			}
			stack = stack[:len(stack)-1]
			var result bool
			switch expr[0] {
			case 't':
				result = true
			case 'f':
				result = false
			case '!':
				result = !expr[1]
			case '&':
				result = true
				for i := 1; i < len(expr); i++ {
					result = result && (expr[i] == 't')
				}
			case '|':
				result = false
				for i := 1; i < len(expr); i++ {
					result = result || (expr[i] == 't')
				}
			}
			stack = append(stack, rune(result))
		}
	}
	return stack[0] == 't'
}