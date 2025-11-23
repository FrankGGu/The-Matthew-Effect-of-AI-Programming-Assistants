package main

func minFlips(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    res := 0
    for i := 0; i < m/2; i++ {
        for j := 0; j < n/2; j++ {
            a, b, c, d := grid[i][j], grid[i][n-1-j], grid[m-1-i][j], grid[m-1-i][n-1-j]
            count := [4]int{a, b, c, d}
            for k := 0; k < 4; k++ {
                if count[k] == 1 {
                    res++
                }
            }
            res -= 3 * (count[0] + count[1] + count[2] + count[3]) / 4
        }
    }
    if m%2 == 1 && n%2 == 1 {
        mid := grid[m/2][n/2]
        if mid == 1 {
            res++
        }
    }
    return res
}