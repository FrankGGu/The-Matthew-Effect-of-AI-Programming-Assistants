func robotSim(commands []int, obstacles [][]int) int {
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    obstacleSet := make(map[[2]int]struct{})
    for _, obs := range obstacles {
        obstacleSet[[2]int{obs[0], obs[1]}] = struct{}{}
    }

    x, y, dir, maxDist := 0, 0, 0, 0
    for _, cmd := range commands {
        if cmd == -2 {
            dir = (dir + 3) % 4
        } else if cmd == -1 {
            dir = (dir + 1) % 4
        } else {
            for i := 0; i < cmd; i++ {
                newX, newY := x + directions[dir][0], y + directions[dir][1]
                if _, ok := obstacleSet[[2]int{newX, newY}]; ok {
                    break
                }
                x, y = newX, newY
                maxDist = max(maxDist, x*x + y*y)
            }
        }
    }
    return maxDist
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}