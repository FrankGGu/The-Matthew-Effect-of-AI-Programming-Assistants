func countCells(n int, m int, queries [][]int) int {
	row := make([]bool, n)
	col := make([]bool, m)
	rowCnt := 0
	colCnt := 0
	for _, q := range queries {
		t, index := q[0], q[1]
		if t == 1 {
			if !row[index-1] {
				row[index-1] = true
				rowCnt++
			}
		} else {
			if !col[index-1] {
				col[index-1] = true
				colCnt++
			}
		}
	}
	return rowCnt * colCnt
}