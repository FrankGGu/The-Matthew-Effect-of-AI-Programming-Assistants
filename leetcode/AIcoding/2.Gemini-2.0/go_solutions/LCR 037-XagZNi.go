func asteroidCollision(asteroids []int) []int {
	stack := []int{}
	for _, ast := range asteroids {
		if ast > 0 {
			stack = append(stack, ast)
		} else {
			for len(stack) > 0 && stack[len(stack)-1] > 0 && stack[len(stack)-1] < -ast {
				stack = stack[:len(stack)-1]
			}
			if len(stack) > 0 && stack[len(stack)-1] > 0 && stack[len(stack)-1] == -ast {
				stack = stack[:len(stack)-1]
			} else if len(stack) == 0 || stack[len(stack)-1] < 0 {
				stack = append(stack, ast)
			}
		}
	}
	return stack
}