func diagonalSort(mat [][]int) [][]int {
	m, n := len(mat), len(mat[0])
	diag := make(map[int][]int)

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			diag[i-j] = append(diag[i-j], mat[i][j])
		}
	}

	for k := range diag {
		sort.Ints(diag[k])
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			mat[i][j] = diag[i-j][0]
			diag[i-j] = diag[i-j][1:]
		}
	}

	return mat
}