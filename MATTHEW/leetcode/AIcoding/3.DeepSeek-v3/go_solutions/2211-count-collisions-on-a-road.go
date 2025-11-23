func countCollisions(directions string) int {
    collisions := 0
    stack := []rune{}

    for _, ch := range directions {
        if len(stack) == 0 {
            stack = append(stack, ch)
            continue
        }

        top := stack[len(stack)-1]
        if top == 'R' && ch == 'L' {
            collisions += 2
            stack = stack[:len(stack)-1]
            ch = 'S'
        } else if top == 'S' && ch == 'L' {
            collisions += 1
            ch = 'S'
        } else if top == 'R' && ch == 'S' {
            collisions += 1
            ch = 'S'
        }

        for len(stack) > 0 {
            top = stack[len(stack)-1]
            if top == 'R' && ch == 'S' {
                collisions += 1
                stack = stack[:len(stack)-1]
            } else {
                break
            }
        }

        stack = append(stack, ch)
    }

    return collisions
}