func robotSim(commands []int, obstacles [][]int) int {
    obstaclesMap := make(map[[2]int]bool)
    for _, obs := range obstacles {
        obstaclesMap[[2]int{obs[0], obs[1]}] = true
    }

    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    dir := 0
    x, y := 0, 0
    maxDist := 0

    for _, cmd := range commands {
        if cmd == -2 {
            dir = (dir + 3) % 4
        } else if cmd == -1 {
            dir = (dir + 1) % 4
        } else {
            for i := 0; i < cmd; i++ {
                nx := x + directions[dir][0]
                ny := y + directions[dir][1]
                if _, ok := obstaclesMap[[2]int{nx, ny}]; ok {
                    break
                }
                x, y = nx, ny
            }
            currentDist := x*x + y*y
            if currentDist > maxDist {
                maxDist = currentDist
            }
        }
    }

    return maxDist
}