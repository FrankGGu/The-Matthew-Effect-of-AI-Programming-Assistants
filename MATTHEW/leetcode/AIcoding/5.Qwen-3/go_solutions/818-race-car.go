package main

func raceCar(target int) int {
    type state struct {
        pos, speed int
    }
    visited := make(map[state]bool)
    queue := []state{{0, 1}}
    visited[state{0, 1}] = true
    steps := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]
            pos, speed := current.pos, current.speed
            if pos == target {
                return steps
            }
            // Accelerate
            nextPos := pos + speed
            nextSpeed := speed * 2
            if nextPos >= 0 && nextPos <= target*2 && !visited[state{nextPos, nextSpeed}] {
                visited[state{nextPos, nextSpeed}] = true
                queue = append(queue, state{nextPos, nextSpeed})
            }
            // Reverse
            nextPos = pos
            nextSpeed = -1
            if speed > 0 {
                nextSpeed = -1
            } else {
                nextSpeed = 1
            }
            if nextPos >= 0 && nextPos <= target*2 && !visited[state{nextPos, nextSpeed}] {
                visited[state{nextPos, nextSpeed}] = true
                queue = append(queue, state{nextPos, nextSpeed})
            }
        }
        steps++
    }
    return -1
}