package main

func robotSim(n int, commands []int, obstacles [][]int) int {
    dx := []int{0, 1, 0, -1}
    dy := []int{1, 0, -1, 0}
    x, y := 0, 0
    dir := 0
    obstacleSet := make(map[[2]int]bool)
    for _, obs := range obstacles {
        obstacleSet[[2]int{obs[0], obs[1]}] = true
    }
    maxDistance := 0
    for i := 0; i < n; i++ {
        if commands[i] == -1 {
            dir = (dir + 1) % 4
        } else if commands[i] == -2 {
            dir = (dir + 3) % 4
        } else {
            steps := commands[i]
            for j := 0; j < steps; j++ {
                nx := x + dx[dir]
                ny := y + dy[dir]
                if obstacleSet[[2]int{nx, ny}] {
                    break
                }
                x, y = nx, ny
                maxDistance = max(maxDistance, x*x+y*y)
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