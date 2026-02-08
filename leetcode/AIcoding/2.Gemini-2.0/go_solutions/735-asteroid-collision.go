func asteroidCollision(asteroids []int) []int {
	stack := []int{}
	for _, a := range asteroids {
		alive := true
		for alive && a < 0 && len(stack) > 0 && stack[len(stack)-1] > 0 {
			if stack[len(stack)-1] < -a {
				stack = stack[:len(stack)-1]
			} else if stack[len(stack)-1] == -a {
				stack = stack[:len(stack)-1]
				alive = false
			} else {
				alive = false
			}
		}
		if alive {
			stack = append(stack, a)
		}
	}
	return stack
}