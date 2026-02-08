func sumOfMatrixAfterQueries(n int, queries [][]int) int64 {
	rowCovered := make([]bool, n)
	colCovered := make([]bool, n)

	var totalSum int64 = 0
	coveredRowsCount := 0
	coveredColsCount := 0

	for i := len(queries) - 1; i >= 0; i-- {
		query := queries[i]
		qType := query[0]
		index := query[1]
		val := int64(query[2])

		if qType == 0 { // Row query
			if !rowCovered[index] {
				rowCovered[index] = true
				coveredRowsCount++
				totalSum += val * int64(n-coveredColsCount)
			}
		} else { // Column query
			if !colCovered[index] {
				colCovered[index] = true
				coveredColsCount++
				totalSum += val * int64(n-coveredRowsCount)
			}
		}

		if coveredRowsCount == n && coveredColsCount == n {
			break
		}
	}

	return totalSum
}