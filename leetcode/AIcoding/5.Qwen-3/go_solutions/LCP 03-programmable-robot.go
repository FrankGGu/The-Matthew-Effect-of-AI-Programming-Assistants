package main

func robotSim(n int, commands []int, obstacles [][]int) int {
    dir := [][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    x, y := 0, 0
    dx, dy := 0, 1
    maxDistance := 0

    obstacleSet := make(map[[2]int]bool)
    for _, o := range obstacles {
        obstacleSet[[2]int{o[0], o[1]}] = true
    }

    for i := 0; i < n; i++ {
        if commands[i] == -1 {
            dx, dy = dir[(dirIndex(dx, dy)+1)%4][0], dir[(dirIndex(dx, dy)+1)%4][1]
        } else if commands[i] == -2 {
            dx, dy = dir[(dirIndex(dx, dy)+3)%4][0], dir[(dirIndex(dx, dy)+3)%4][1]
        } else {
            steps := commands[i]
            for j := 0; j < steps; j++ {
                nextX, nextY := x+dx, y+dy
                if obstacleSet[[2]int{nextX, nextY}] {
                    break
                }
                x, y = nextX, nextY
                maxDistance = max(maxDistance, x*x+y*y)
            }
        }
    }

    return maxDistance
}

func dirIndex(dx, dy int) int {
    if dx == 0 && dy == 1 {
        return 0
    } else if dx == 1 && dy == 0 {
        return 1
    } else if dx == 0 && dy == -1 {
        return 2
    } else {
        return 3
    }
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}