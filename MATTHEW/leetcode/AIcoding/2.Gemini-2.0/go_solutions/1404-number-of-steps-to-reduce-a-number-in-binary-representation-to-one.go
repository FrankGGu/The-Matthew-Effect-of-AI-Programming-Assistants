func numSteps(s string) int {
	n := len(s)
	carry := 0
	steps := 0
	for i := n - 1; i > 0; i-- {
		digit := int(s[i] - '0') + carry
		if digit%2 == 0 {
			carry = digit / 2
		} else {
			carry = (digit + 1) / 2
			steps++
		}
		steps++
	}
	return steps + carry
}