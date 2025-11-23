func matrixReshape(mat [][]int, r int, c int) [][]int {
	m := len(mat)
	n := len(mat[0])
	if m*n != r*c {
		return mat
	}

	reshaped := make([][]int, r)
	for i := 0; i < r; i++ {
		reshaped[i] = make([]int, c)
	}

	for i := 0; i < r; i++ {
		for j := 0; j < c; j++ {
			index := i*c + j
			reshaped[i][j] = mat[index/n][index%n]
		}
	}

	return reshaped
}