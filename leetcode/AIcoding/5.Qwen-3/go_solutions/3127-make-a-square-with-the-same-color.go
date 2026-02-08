package main

func findSquare(grid [][]int) []int {
    m, n := len(grid), len(grid[0])
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                for k := 1; k <= min(m-i, n-j); k++ {
                    valid := true
                    for x := 0; x < k; x++ {
                        if grid[i+x][j+k-1] != 1 {
                            valid = false
                            break
                        }
                    }
                    if !valid {
                        continue
                    }
                    for y := 0; y < k; y++ {
                        if grid[i+k-1][j+y] != 1 {
                            valid = false
                            break
                        }
                    }
                    if !valid {
                        continue
                    }
                    return []int{i, j, k}
                }
            }
        }
    }
    return []int{-1, -1, 0}
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}