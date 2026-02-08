func getBiggestThree(grid [][]int) []int {
    m, n := len(grid), len(grid[0])
    sums := make(map[int]struct{})

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            sums[grid[i][j]] = struct{}{}
            maxLen := min(i, m-1-i, j, n-1-j)
            for l := 1; l <= maxLen; l++ {
                sum := 0
                x, y := i-l, j
                for k := 0; k < l; k++ {
                    sum += grid[x+k][y+k]
                }
                x, y = i, j+l
                for k := 0; k < l; k++ {
                    sum += grid[x+k][y-k]
                }
                x, y = i+l, j
                for k := 0; k < l; k++ {
                    sum += grid[x-k][y-k]
                }
                x, y = i, j-l
                for k := 0; k < l; k++ {
                    sum += grid[x-k][y+k]
                }
                sums[sum] = struct{}{}
            }
        }
    }

    res := make([]int, 0, len(sums))
    for k := range sums {
        res = append(res, k)
    }
    sort.Slice(res, func(i, j int) bool {
        return res[i] > res[j]
    })
    if len(res) > 3 {
        res = res[:3]
    }
    return res
}

func min(a, b, c, d int) int {
    res := a
    if b < res {
        res = b
    }
    if c < res {
        res = c
    }
    if d < res {
        res = d
    }
    return res
}