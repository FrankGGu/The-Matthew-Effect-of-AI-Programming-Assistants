func calculate(s string) int {
	stack := []int{}
	num := 0
	op := 1
	res := 0
	for i := 0; i < len(s); i++ {
		switch s[i] {
		case ' ':
			continue
		case '+':
			res += op * num
			num = 0
			op = 1
		case '-':
			res += op * num
			num = 0
			op = -1
		case '(':
			stack = append(stack, res)
			stack = append(stack, op)
			res = 0
			op = 1
		case ')':
			res += op * num
			num = 0
			op = stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			res *= op
			res += stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			op = 1
		default:
			num = num*10 + int(s[i]-'0')
		}
	}
	res += op * num
	return res
}