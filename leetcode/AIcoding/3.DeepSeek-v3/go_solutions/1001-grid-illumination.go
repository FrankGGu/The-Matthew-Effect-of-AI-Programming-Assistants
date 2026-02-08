func gridIllumination(n int, lamps [][]int, queries [][]int) []int {
    type pair struct{ x, y int }
    lampSet := make(map[pair]bool)
    row := make(map[int]int)
    col := make(map[int]int)
    diag1 := make(map[int]int)
    diag2 := make(map[int]int)

    for _, lamp := range lamps {
        x, y := lamp[0], lamp[1]
        p := pair{x, y}
        if !lampSet[p] {
            lampSet[p] = true
            row[x]++
            col[y]++
            diag1[x-y]++
            diag2[x+y]++
        }
    }

    directions := [][]int{{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 0}, {0, 1}, {1, -1}, {1, 0}, {1, 1}}
    result := make([]int, len(queries))
    for i, query := range queries {
        x, y := query[0], query[1]
        if row[x] > 0 || col[y] > 0 || diag1[x-y] > 0 || diag2[x+y] > 0 {
            result[i] = 1
        } else {
            result[i] = 0
        }

        for _, dir := range directions {
            nx, ny := x+dir[0], y+dir[1]
            if nx >= 0 && nx < n && ny >= 0 && ny < n {
                p := pair{nx, ny}
                if lampSet[p] {
                    lampSet[p] = false
                    row[nx]--
                    col[ny]--
                    diag1[nx-ny]--
                    diag2[nx+ny]--
                }
            }
        }
    }
    return result
}