func matrixReshape(mat [][]int, r int, c int) [][]int {
	m := len(mat)
	n := len(mat[0])

	if m*n != r*c {
		return mat
	}

	reshapedMat := make([][]int, r)
	for i := 0; i < r; i++ {
		reshapedMat[i] = make([]int, c)
	}

	for i := 0; i < m*n; i++ {
		originalRow := i / n
		originalCol := i % n

		newRow := i / c
		newCol := i % c

		reshapedMat[newRow][newCol] = mat[originalRow][originalCol]
	}

	return reshapedMat
}