func cellsInRange(s string) []string {
	startCol := rune(s[0])
	startRow := int(s[1] - '0')
	endCol := rune(s[3])
	endRow := int(s[4] - '0')

	var result []string
	for col := startCol; col <= endCol; col++ {
		for row := startRow; row <= endRow; row++ {
			cell := string(col) + string(row+'0')
			result = append(result, cell)
		}
	}

	return result
}