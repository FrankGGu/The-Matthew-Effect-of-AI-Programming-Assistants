func gridIllumination(n int, lamps [][]int, queries [][]int) []int {
	row := make(map[int]int)
	col := make(map[int]int)
	diag1 := make(map[int]int)
	diag2 := make(map[int]int)
	lampSet := make(map[int]map[int]bool)

	for _, lamp := range lamps {
		r, c := lamp[0], lamp[1]
		if _, ok := lampSet[r]; !ok {
			lampSet[r] = make(map[int]bool)
		}
		if lampSet[r][c] {
			continue
		}
		lampSet[r][c] = true
		row[r]++
		col[c]++
		diag1[r-c]++
		diag2[r+c]++
	}

	ans := make([]int, len(queries))
	for i, query := range queries {
		r, c := query[0], query[1]
		if row[r] > 0 || col[c] > 0 || diag1[r-c] > 0 || diag2[r+c] > 0 {
			ans[i] = 1
		}

		for dr := -1; dr <= 1; dr++ {
			for dc := -1; dc <= 1; dc++ {
				nr, nc := r+dr, c+dc
				if nr >= 0 && nr < n && nc >= 0 && nc < n {
					if _, ok := lampSet[nr]; ok {
						if lampSet[nr][nc] {
							lampSet[nr][nc] = false
							row[nr]--
							col[nc]--
							diag1[nr-nc]--
							diag2[nr+nc]--
							if row[nr] == 0 {
								delete(row, nr)
							}
							if col[nc] == 0 {
								delete(col, nc)
							}
							if diag1[nr-nc] == 0 {
								delete(diag1, nr-nc)
							}
							if diag2[nr+nc] == 0 {
								delete(diag2, nr+nc)
							}
						}
					}
				}
			}
		}
	}

	return ans
}