package main

func robotSim(headings [][]int, commands []int) []int {
    dir := 0
    dx := []int{0, 1, 0, -1}
    dy := []int{1, 0, -1, 0}
    x, y := 0, 0
    maxDistance := 0
    obstacles := make(map[string]bool)
    for _, obstacle := range headings {
        obstacles[fmt.Sprintf("%d,%d", obstacle[0], obstacle[1])] = true
    }
    for _, command := range commands {
        if command == -1 {
            dir = (dir + 1) % 4
        } else if command == -2 {
            dir = (dir + 3) % 4
        } else {
            for i := 0; i < command; i++ {
                nx := x + dx[dir]
                ny := y + dy[dir]
                if _, ok := obstacles[fmt.Sprintf("%d,%d", nx, ny)]; ok {
                    break
                }
                x, y = nx, ny
                maxDistance = max(maxDistance, x*x+y*y)
            }
        }
    }
    return []int{x, y}
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}