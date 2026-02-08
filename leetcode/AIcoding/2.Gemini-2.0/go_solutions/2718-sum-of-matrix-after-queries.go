func sumOfMatrixAfterQueries(n int, queries [][]int) int64 {
	row := make([]bool, n)
	col := make([]bool, n)
	rowCnt := 0
	colCnt := 0
	ans := int64(0)

	for i := len(queries) - 1; i >= 0; i-- {
		t := queries[i][0]
		idx := queries[i][1]
		val := queries[i][2]

		if t == 0 {
			if !row[idx] {
				ans += int64(val) * int64(n-colCnt)
				row[idx] = true
				rowCnt++
			}
		} else {
			if !col[idx] {
				ans += int64(val) * int64(n-rowCnt)
				col[idx] = true
				colCnt++
			}
		}

		if rowCnt == n && colCnt == n {
			break
		}
	}

	return ans
}