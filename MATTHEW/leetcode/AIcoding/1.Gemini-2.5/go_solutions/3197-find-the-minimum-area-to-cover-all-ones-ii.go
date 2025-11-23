import "math"

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func getBoundingBoxArea(grid [][]int, r1, c1, r2, c2 int) int {
	minR, maxR, minC, maxC := math.MaxInt32, math.MinInt32, math.MaxInt32, math.MinInt32
	found := false
	for r := r1; r <= r2; r++ {
		for c := c1; c <= c2; c++ {
			if grid[r][c] == 1 {
				found = true
				minR = min(minR, r)
				maxR = max(maxR, r)
				minC = min(minC, c)
				maxC = max(maxC, c)
			}
		}
	}
	if !found {
		return 0
	}
	return (maxR - minR + 1) * (maxC - minC + 1)
}

func minimumArea(grid [][]int) int {
	R := len(grid)
	C := len(grid[0])

	minTotalArea := math.MaxInt32

	// Case 1: Three horizontal strips
	// R1: rows 0..i
	// R2: rows i+1..j
	// R3: rows j+1..R-1
	for i := 0; i < R-2; i++ {
		for j := i + 1; j < R-1; j++ {
			area1 := getBoundingBoxArea(grid, 0, 0, i, C-1)
			area2 := getBoundingBoxArea(grid, i+1, 0, j, C-1)
			area3 := getBoundingBoxArea(grid, j+1, 0, R-1, C-1)
			minTotalArea = min(minTotalArea, area1+area2+area3)
		}
	}

	// Case 2: Three vertical strips
	// R1: cols 0..i
	// R2: cols i+1..j
	// R3: cols j+1..C-1
	for i := 0; i < C-2; i++ {
		for j := i + 1; j < C-1; j++ {
			area1 := getBoundingBoxArea(grid, 0, 0, R-1, i)
			area2 := getBoundingBoxArea(grid, 0, i+1, R-1, j)
			area3 := getBoundingBoxArea(grid, 0, j+1, R-1, C-1)
			minTotalArea = min(minTotalArea, area1+area2+area3)
		}
	}

	// Case 3: One horizontal strip, remaining split vertically
	// 3a: Top strip (R1), bottom part split (R2, R3)
	// R1: rows 0..i
	// R2: rows i+1..R-1, cols 0..j
	// R3: rows i+1..R-1, cols j+1..C-1
	for i := 0; i < R-1; i++ { // i is the row index of the horizontal cut
		for j := 0; j < C-1; j++ { // j is the column index of the vertical cut in the bottom part
			area1 := getBoundingBoxArea(grid, 0, 0, i, C-1)
			area2 := getBoundingBoxArea(grid, i+1, 0, R-1, j)
			area3 := getBoundingBoxArea(grid, i+1, j+1, R-1, C-1)
			minTotalArea = min(minTotalArea, area1+area2+area3)
		}
	}

	// 3b: Bottom strip (R1), top part split (R2, R3)
	// R1: rows i+1..R-1
	// R2: rows 0..i, cols 0..j
	// R3: rows 0..i, cols j+1..C-1
	for i := 0; i < R-1; i++ { // i is the row index of the horizontal cut
		for j := 0; j < C-1; j++ { // j is the column index of the vertical cut in the top part
			area1 := getBoundingBoxArea(grid, i+1, 0, R-1, C-1)
			area2 := getBoundingBoxArea(grid, 0, 0, i, j)
			area3 := getBoundingBoxArea(grid, 0, j+1, i, C-1)
			minTotalArea = min(minTotalArea, area1+area2+area3)
		}
	}

	// Case 4: One vertical strip, remaining split horizontally
	// 4a: Left strip (R1), right part split (R2, R3)
	// R1: cols 0..i
	// R2: cols i+1..C-1, rows 0..j
	// R3: cols i+1..C-1, rows j+1..R-1
	for i := 0; i < C-1; i++ { // i is the column index of the vertical cut
		for j := 0; j < R-1; j++ { // j is the row index of the horizontal cut in the right part
			area1 := getBoundingBoxArea(grid, 0, 0, R-1, i)
			area2 := getBoundingBoxArea(grid, 0, i+1, j, C-1)
			area3 := getBoundingBoxArea(grid, j+1, i+1, R-1, C-1)
			minTotalArea = min(minTotalArea, area1+area2+area3)
		}
	}

	// 4b: Right strip (R1), left part split (R2, R3)
	// R1: cols i+1..C-1
	// R2: cols 0..i, rows 0..j
	// R3: cols 0..i, rows j+1..R-1
	for i := 0; i < C-1; i++ { // i is the column index of the vertical cut
		for j := 0; j < R-1; j++ { // j is the row index of the horizontal cut in the left part
			area1 := getBoundingBoxArea(grid, 0, i+1, R-1, C-1)
			area2 := getBoundingBoxArea(grid, 0, 0, j, i)
			area3 := getBoundingBoxArea(grid, j+1, 0, R-1, i)
			minTotalArea = min(minTotalArea, area1+area2+area3)
		}
	}

	return minTotalArea
}