package main

func minCost(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dirs := [4][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    cost := make([][]int, m)
    for i := range cost {
        cost[i] = make([]int, n)
        for j := range cost[i] {
            cost[i][j] = -1
        }
    }
    queue := [][2]int{{0, 0}}
    cost[0][0] = 0
    for len(queue) > 0 {
        i, j := queue[0][0], queue[0][1]
        queue = queue[1:]
        for d := 0; d < 4; d++ {
            ni, nj := i+dirs[d][0], j+dirs[d][1]
            if ni >= 0 && ni < m && nj >= 0 && nj < n {
                newCost := cost[i][j] + (1 if d != grid[i][j]-1 else 0)
                if cost[ni][nj] == -1 || newCost < cost[ni][nj] {
                    cost[ni][nj] = newCost
                    queue = append(queue, [2]int{ni, nj})
                }
            }
        }
    }
    return cost[m-1][n-1]
}