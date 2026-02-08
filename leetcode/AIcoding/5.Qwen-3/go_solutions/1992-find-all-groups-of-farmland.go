package main

func findFarmland(land [][]int) [][]int {
    m := len(land)
    n := len(land[0])
    result := [][]int{}
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if land[i][j] == 1 {
                x, y := i, j
                for x+1 < m && land[x+1][y] == 1 {
                    x++
                }
                for y+1 < n && land[x][y+1] == 1 {
                    y++
                }
                result = append(result, []int{i, j, x, y})
                for a := i; a <= x; a++ {
                    for b := j; b <= y; b++ {
                        land[a][b] = 0
                    }
                }
            }
        }
    }
    return result
}