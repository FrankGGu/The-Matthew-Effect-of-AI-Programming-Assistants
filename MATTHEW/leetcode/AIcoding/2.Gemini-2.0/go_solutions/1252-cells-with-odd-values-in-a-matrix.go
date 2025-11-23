func oddCells(m int, n int, indices [][]int) int {
	rows := make([]int, m)
	cols := make([]int, n)

	for _, index := range indices {
		rows[index[0]]++
		cols[index[1]]++
	}

	count := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if (rows[i]+cols[j])%2 != 0 {
				count++
			}
		}
	}

	return count
}