func asteroidCollision(asteroids []int) []int {
    stack := make([]int, 0)
    for _, a := range asteroids {
        for len(stack) > 0 && stack[len(stack)-1] > 0 && a < 0 {
            diff := stack[len(stack)-1] + a
            if diff < 0 {
                stack = stack[:len(stack)-1]
            } else if diff > 0 {
                a = 0
            } else {
                stack = stack[:len(stack)-1]
                a = 0
            }
        }
        if a != 0 {
            stack = append(stack, a)
        }
    }
    return stack
}