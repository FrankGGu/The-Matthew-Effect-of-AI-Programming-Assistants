func smallestNumber(pattern string) string {
	n := len(pattern)
	res := make([]byte, n+1)
	stack := []int{}
	idx := 0
	for i := 0; i <= n; i++ {
		stack = append(stack, i+1)
		if i == n || pattern[i] == 'I' {
			for len(stack) > 0 {
				res[idx] = byte(stack[len(stack)-1]+'0')
				stack = stack[:len(stack)-1]
				idx++
			}
		}
	}
	return string(res)
}