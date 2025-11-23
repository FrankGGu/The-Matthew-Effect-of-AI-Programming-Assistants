package main

func possibleToStamp(grid [][]int, target [][]int) bool {
    m, n := len(grid), len(grid[0])
    k, l := len(target), len(target[0])

    if k > m || l > n {
        return false
    }

    diff := make([][]int, m+1)
    for i := range diff {
        diff[i] = make([]int, n+1)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                if i+k <= m && j+l <= n {
                    diff[i][j]++
                    diff[i+k][j]--
                    diff[i][j+l]--
                    diff[i+k][j+l]++
                }
            }
        }
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if i > 0 {
                diff[i][j] += diff[i-1][j]
            }
            if j > 0 {
                diff[i][j] += diff[i][j-1]
            }
            if i > 0 && j > 0 {
                diff[i][j] -= diff[i-1][j-1]
            }
            if diff[i][j] > 0 {
                if i+k <= m && j+l <= n {
                    for x := i; x < i+k; x++ {
                        for y := j; y < j+l; y++ {
                            if grid[x][y] != 1 || target[x-i][y-j] != 1 {
                                return false
                            }
                        }
                    }
                } else {
                    return false
                }
            }
        }
    }

    return true
}