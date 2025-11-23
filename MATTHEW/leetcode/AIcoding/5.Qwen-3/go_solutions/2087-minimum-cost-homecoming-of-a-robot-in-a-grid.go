package main

func minCost(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    directions := [4][2]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    cost := [4]int{1, 1, 1, 1}

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                for k := 0; k < 4; k++ {
                    ni, nj := i+directions[k][0], j+directions[k][1]
                    if ni >= 0 && ni < m && nj >= 0 && nj < n {
                        grid[ni][nj] += cost[k]
                    }
                }
            }
        }
    }

    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            if grid[i][j] == 1 {
                for k := 0; k < 4; k++ {
                    ni, nj := i+directions[k][0], j+directions[k][1]
                    if ni >= 0 && ni < m && nj >= 0 && nj < n {
                        grid[ni][nj] += cost[k]
                    }
                }
            }
        }
    }

    return grid[0][0]
}