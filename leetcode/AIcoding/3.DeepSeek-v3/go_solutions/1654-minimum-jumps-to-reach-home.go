func minimumJumps(forbidden []int, a int, b int, x int) int {
    maxLimit := 2000 + 2*b
    forbiddenSet := make(map[int]bool)
    for _, num := range forbidden {
        forbiddenSet[num] = true
        if num > maxLimit {
            maxLimit = num + 2*b
        }
    }

    visited := make(map[[2]int]bool)
    queue := [][3]int{{0, 0, 0}} // position, steps, direction (0: any, 1: backward)

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]
        pos, steps, dir := current[0], current[1], current[2]

        if pos == x {
            return steps
        }

        if pos > maxLimit || pos < 0 {
            continue
        }

        if forbiddenSet[pos] {
            continue
        }

        key := [2]int{pos, dir}
        if visited[key] {
            continue
        }
        visited[key] = true

        // Jump forward
        newPos := pos + a
        if !forbiddenSet[newPos] && !visited[[2]int{newPos, 0}] {
            queue = append(queue, [3]int{newPos, steps + 1, 0})
        }

        // Jump backward only if previous move was not backward
        if dir != 1 {
            newPos = pos - b
            if newPos >= 0 && !forbiddenSet[newPos] && !visited[[2]int{newPos, 1}] {
                queue = append(queue, [3]int{newPos, steps + 1, 1})
            }
        }
    }

    return -1
}