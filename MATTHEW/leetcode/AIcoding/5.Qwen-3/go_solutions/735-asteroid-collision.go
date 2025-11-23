package main

func asteroidCollision(asteroids []int) []int {
	stack := []int{}
	for _, ast := range asteroids {
		collide := true
		for len(stack) > 0 && stack[len(stack)-1] > 0 && ast < 0 {
			if stack[len(stack)-1] < -ast {
				stack = stack[:len(stack)-1]
			} else if stack[len(stack)-1] == -ast {
				stack = stack[:len(stack)-1]
				collide = false
				break
			} else {
				collide = false
				break
			}
		}
		if collide {
			stack = append(stack, ast)
		}
	}
	return stack
}