func canMakeSquare(grid []string) bool {
	for r := 0; r <= 1; r++ {
		for c := 0; c <= 1; c++ {
			countB := 0
			countW := 0

			if grid[r][c] == 'B' {
				countB++