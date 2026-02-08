func asteroidCollision(asteroids []int) []int {
    stack := []int{}
    for _, asteroid := range asteroids {
        collision := false
        for collision == false {
            if len(stack) == 0 || asteroid > 0 {
                stack = append(stack, asteroid)
                collision = true
            } else {
                top := stack[len(stack)-1]
                if top < 0 {
                    stack = append(stack, asteroid)
                    collision = true
                } else if top == -asteroid {
                    stack = stack[:len(stack)-1]
                    collision = true
                } else if top > -asteroid {
                    collision = true
                } else {
                    stack = stack[:len(stack)-1]
                }
            }
        }
    }
    return stack
}