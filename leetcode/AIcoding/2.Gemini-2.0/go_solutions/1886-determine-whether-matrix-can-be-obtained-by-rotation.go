func findRotation(mat [][]int, target [][]int) bool {
	n := len(mat)
	for i := 0; i < 4; i++ {
		if isEqual(mat, target) {
			return true
		}
		rotate(mat)
	}
	return false
}

func isEqual(mat [][]int, target [][]int) bool {
	n := len(mat)
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if mat[i][j] != target[i][j] {
				return false
			}
		}
	}
	return true
}

func rotate(mat [][]int) {
	n := len(mat)
	for i := 0; i < n/2; i++ {
		for j := i; j < n-i-1; j++ {
			temp := mat[i][j]
			mat[i][j] = mat[n-1-j][i]
			mat[n-1-j][i] = mat[n-1-i][n-1-j]
			mat[n-1-i][n-1-j] = mat[j][n-1-i]
			mat[j][n-1-i] = temp
		}
	}
}