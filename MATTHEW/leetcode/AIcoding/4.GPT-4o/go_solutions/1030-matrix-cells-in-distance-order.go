func allCellsDistOrder(R int, C int, r0 int, c0 int) [][]int {
    cells := make([][]int, R*C)
    index := 0

    for r := 0; r < R; r++ {
        for c := 0; c < C; c++ {
            cells[index] = []int{r, c}
            index++
        }
    }

    sort.Slice(cells, func(i, j int) bool {
        distI := abs(cells[i][0]-r0) + abs(cells[i][1]-c0)
        distJ := abs(cells[j][0]-r0) + abs(cells[j][1]-c0)
        return distI < distJ
    })

    return cells
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}