func champagneTower(poured int, query_row int, query_glass int) float64 {
	tower := make([][]float64, query_row+1)
	for i := range tower {
		tower[i] = make([]float64, i+1)
	}

	tower[0][0] = float64(poured)

	for i := 0; i < query_row; i++ {
		for j := 0; j <= i; j++ {
			if tower[i][j] > 1 {
				excess := (tower[i][j] - 1) / 2
				tower[i+1][j] += excess
				tower[i+1][j+1] += excess
			}
		}
	}

	if tower[query_row][query_glass] > 1 {
		return 1
	}
	return tower[query_row][query_glass]
}