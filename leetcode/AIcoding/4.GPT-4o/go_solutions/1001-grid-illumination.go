func gridIllumination(N int, lamps [][]int, queries [][]int) []int {
    lampCount := make(map[[2]int]int)
    rowCount := make(map[int]int)
    colCount := make(map[int]int)
    diagCount := make(map[int]int)
    antiDiagCount := make(map[int]int)

    for _, lamp := range lamps {
        x, y := lamp[0], lamp[1]
        lampCount[[2]int{x, y}]++
        rowCount[x]++
        colCount[y]++
        diagCount[x-y]++
        antiDiagCount[x+y]++
    }

    result := make([]int, len(queries))
    directions := [][2]int{{0, 0}, {1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}}

    for i, query := range queries {
        x, y := query[0], query[1]
        if rowCount[x] > 0 || colCount[y] > 0 || diagCount[x-y] > 0 || antiDiagCount[x+y] > 0 {
            result[i] = 1
        }

        for _, d := range directions {
            nx, ny := x+d[0], y+d[1]
            if _, exists := lampCount[[2]int{nx, ny}]; exists {
                delete(lampCount, [2]int{nx, ny})
                rowCount[nx]--
                colCount[ny]--
                diagCount[nx-ny]--
                antiDiagCount[nx+ny]--
            }
        }
    }

    return result
}