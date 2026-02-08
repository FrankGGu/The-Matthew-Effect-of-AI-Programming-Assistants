package main

func surfaceArea(grid [][]int) int {
	totalArea := 0
	m := len(grid)
	n := len(grid[0])

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			h := grid[i][j]
			if h == 0 {
				continue
			}

			totalArea += 2 // Top and Bottom faces

			// North face
			if i == 0 {
				totalArea += h
			} else {
				totalArea += max(0, h-grid[i-1][j])
			}

			// South face
			if i == m-1 {
				totalArea += h
			} else {
				totalArea += max(0, h-grid[i+1][j])
			}

			// West face
			if j == 0 {
				totalArea += h
			} else {
				totalArea += max(0, h-grid[i][j-1])
			}

			// East face
			if j == n-1 {
				totalArea += h
			} else {
				totalArea += max(0, h-grid[i][j+1])
			}
		}
	}
	return totalArea
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}