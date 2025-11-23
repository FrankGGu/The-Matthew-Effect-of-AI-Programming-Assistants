package main

func checkValidMatrix(matrix [][]int) bool {
	n := len(matrix)
	for i := 0; i < n; i++ {
		seenRow := make(map[int]bool)
		seenCol := make(map[int]bool)
		for j := 0; j < n; j++ {
			if matrix[i][j] < 1 || matrix[i][j] > n {
				return false
			}
			seenRow[matrix[i][j]] = true
			seenCol[matrix[j][i]] = true
		}
		if len(seenRow) != n || len(seenCol) != n {
			return false
		}
	}
	return true
}