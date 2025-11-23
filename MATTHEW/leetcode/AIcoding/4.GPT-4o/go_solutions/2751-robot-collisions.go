func robotCollision(robots []int) int {
    stack := []int{}
    for _, r := range robots {
        if r < 0 {
            for len(stack) > 0 && stack[len(stack)-1] > 0 && r < 0 {
                if stack[len(stack)-1] + r == 0 {
                    stack = stack[:len(stack)-1]
                    r = 0
                } else if stack[len(stack)-1] + r < 0 {
                    stack = stack[:len(stack)-1]
                } else {
                    r = 0
                }
            }
        } else {
            stack = append(stack, r)
        }
    }
    return len(stack)
}