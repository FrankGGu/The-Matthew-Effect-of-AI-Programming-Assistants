func cellsInRange(s string) []string {
	startCol := s[0]
	startRow := s[1]
	endCol := s[3]
	endRow := s[4]

	result := []string{}

	for c := startCol; c <= endCol; c++ {
		for r := startRow; r <= endRow; r++ {
			cell := string(c) + string(r)
			result = append(result, cell)
		}
	}

	return result
}