func allCellsDistOrder(rows int, cols int, rCenter int, cCenter int) [][]int {
    cells := make([][]int, 0, rows*cols)
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            cells = append(cells, []int{i, j})
        }
    }

    sort.Slice(cells, func(i, j int) bool {
        d1 := abs(cells[i][0] - rCenter) + abs(cells[i][1] - cCenter)
        d2 := abs(cells[j][0] - rCenter) + abs(cells[j][1] - cCenter)
        return d1 < d2
    })

    return cells
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}