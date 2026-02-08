package main

func rotateGrid(grid [][]int, k int) [][]int {
    m := len(grid)
    n := len(grid[0])
    result := make([][]int, m)
    for i := range result {
        result[i] = make([]int, n)
    }
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            result[i][j] = grid[i][j]
        }
    }
    for k > 0 {
        for i := 0; i < m; i++ {
            for j := 0; j < n; j++ {
                if i == 0 && j == 0 {
                    temp := result[i][j]
                    for x := 0; x < m; x++ {
                        for y := 0; y < n; y++ {
                            if x == 0 && y == 0 {
                                continue
                            }
                            if x == 0 && y == n-1 {
                                result[x][y] = temp
                            } else if x == m-1 && y == n-1 {
                                result[x][y] = result[x-1][y]
                            } else if x == m-1 && y == 0 {
                                result[x][y] = result[x][y+1]
                            } else if x == 0 {
                                result[x][y] = result[x][y+1]
                            } else if y == n-1 {
                                result[x][y] = result[x-1][y]
                            } else if x == m-1 {
                                result[x][y] = result[x][y-1]
                            } else if y == 0 {
                                result[x][y] = result[x+1][y]
                            }
                        }
                    }
                }
            }
        }
        k--
    }
    return result
}