func asteroidCollision(asteroids []int) []int {
    stack := []int{}

    for _, asteroid := range asteroids {
        alive := true
        for alive && asteroid < 0 && len(stack) > 0 && stack[len(stack)-1] > 0 {
            if stack[len(stack)-1] < -asteroid {
                stack = stack[:len(stack)-1]
            } else if stack[len(stack)-1] == -asteroid {
                stack = stack[:len(stack)-1]
                alive = false
            } else {
                alive = false
            }
        }
        if alive {
            stack = append(stack, asteroid)
        }
    }

    return stack
}