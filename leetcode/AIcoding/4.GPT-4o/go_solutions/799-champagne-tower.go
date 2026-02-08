func champagneTower(poured int, query_row int, query_glass int) float64 {
    tower := make([][]float64, query_row+2)
    for i := range tower {
        tower[i] = make([]float64, i+1)
    }

    tower[0][0] = float64(poured)

    for r := 0; r < query_row; r++ {
        for g := 0; g <= r; g++ {
            if tower[r][g] > 1 {
                overflow := (tower[r][g] - 1) / 2
                tower[r+1][g] += overflow
                tower[r+1][g+1] += overflow
            }
        }
    }

    if tower[query_row][query_glass] > 1 {
        return 1
    }
    return tower[query_row][query_glass]
}