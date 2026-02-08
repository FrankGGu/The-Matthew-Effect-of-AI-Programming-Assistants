func robotSim(commands []int, obstacles [][]int) int {
    direction := []int{0, 1} // [dx, dy]
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    obstacleSet := make(map[[2]int]struct{})
    for _, obs := range obstacles {
        obstacleSet[[2]int{obs[0], obs[1]}] = struct{}{}
    }

    x, y, maxDistance := 0, 0, 0
    dirIndex := 0

    for _, command := range commands {
        if command == -2 { // turn left
            dirIndex = (dirIndex + 3) % 4
        } else if command == -1 { // turn right
            dirIndex = (dirIndex + 1) % 4
        } else {
            for i := 0; i < command; i++ {
                nextX := x + directions[dirIndex][0]
                nextY := y + directions[dirIndex][1]
                if _, exists := obstacleSet[[2]int{nextX, nextY}]; !exists {
                    x, y = nextX, nextY
                    maxDistance = max(maxDistance, x*x+y*y)
                } else {
                    break
                }
            }
        }
    }

    return maxDistance
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}