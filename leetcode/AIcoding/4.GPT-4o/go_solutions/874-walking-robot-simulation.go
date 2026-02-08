func robotSim(commands []int, obstacles [][]int) int {
    direction := []int{0, 1} // 初始方向向上
    position := []int{0, 0}   // 初始位置
    obstacleSet := make(map[[2]int]struct{})

    for _, ob := range obstacles {
        obstacleSet[[2]int{ob[0], ob[1]}] = struct{}{}
    }

    maxDistance := 0

    for _, command := range commands {
        if command == -1 { // 右转
            direction[0], direction[1] = direction[1], -direction[0]
        } else if command == -2 { // 左转
            direction[0], direction[1] = -direction[1], direction[0]
        } else { // 前进
            for i := 0; i < command; i++ {
                nextPosition := []int{position[0] + direction[0], position[1] + direction[1]}
                if _, found := obstacleSet[[2]int{nextPosition[0], nextPosition[1]}]; found {
                    break
                }
                position = nextPosition
                maxDistance = max(maxDistance, position[0]*position[0]+position[1]*position[1])
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