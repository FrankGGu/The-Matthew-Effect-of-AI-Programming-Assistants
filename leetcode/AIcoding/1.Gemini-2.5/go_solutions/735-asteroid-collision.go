func asteroidCollision(asteroids []int) []int {
    stack := []int{}

    for _, ast := range asteroids {
        pushCurrent := true
        for len(stack) > 0 && ast < 0 && stack[len(stack)-1] > 0 {
            // Collision scenario: current 'ast' is left-moving,