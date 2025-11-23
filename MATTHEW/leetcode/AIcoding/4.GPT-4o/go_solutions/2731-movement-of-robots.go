func robotSim(commands []int, obstacles [][]int) int {
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    dir := 0
    pos := []int{0, 0}
    obstacleSet := make(map[[2]int]struct{})

    for _, obs := range obstacles {
        obstacleSet[[2]int{obs[0], obs[1]}] = struct{}{}
    }

    maxDistSq := 0

    for _, cmd := range commands {
        if cmd == -2 {
            dir = (dir + 3) % 4
        } else if cmd == -1 {
            dir = (dir + 1) % 4
        } else {
            for i := 0; i < cmd; i++ {
                newPos := []int{pos[0] + directions[dir][0], pos[1] + directions[dir][1]}
                if _, exists := obstacleSet[[2]int{newPos[0], newPos[1]}]; exists {
                    break
                }
                pos = newPos
                maxDistSq = max(maxDistSq, pos[0]*pos[0]+pos[1]*pos[1])
            }
        }
    }

    return maxDistSq
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}