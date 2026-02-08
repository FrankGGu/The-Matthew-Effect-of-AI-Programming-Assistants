func findFarmland(land [][]int) [][]int {
    var res [][]int
    m, n := len(land), len(land[0])
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if land[i][j] == 1 {
                r1, c1 := i, j
                r2, c2 := i, j
                for r2 < m && land[r2][j] == 1 {
                    r2++
                }
                r2--
                for c2 < n && land[i][c2] == 1 {
                    c2++
                }
                c2--
                for x := r1; x <= r2; x++ {
                    for y := c1; y <= c2; y++ {
                        land[x][y] = 0
                    }
                }
                res = append(res, []int{r1, c1, r2, c2})
            }
        }
    }
    return res
}