func numberOfBeams(bank []string) int {
	totalBeams := 0
	prevRowCount := 0

	for _, row := range bank {
		currentRowCount := strings.Count(row, "1")

		if currentRowCount > 0 {
			if prevRowCount > 0 {
				totalBeams += prevRowCount * currentRowCount
			}
			prevRowCount = currentRowCount
		}
	}

	return totalBeams
}