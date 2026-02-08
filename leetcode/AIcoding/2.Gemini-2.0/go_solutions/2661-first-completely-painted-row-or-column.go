func firstCompleteIndex(arr []int, mat [][]int) int {
	m := len(mat)
	n := len(mat[0])
	pos := make(map[int][2]int)
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			pos[mat[i][j]] = [2]int{i, j}
		}
	}
	row := make([]int, m)
	col := make([]int, n)
	for i, v := range arr {
		r, c := pos[v][0], pos[v][1]
		row[r]++
		col[c]++
		if row[r] == n || col[c] == m {
			return i
		}
	}
	return -1
}