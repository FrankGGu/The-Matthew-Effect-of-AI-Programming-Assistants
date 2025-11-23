package main

type Point struct {
	X, Y int
}

type diagExtremes struct {
	minCoord int
	maxCoord int
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func longestVShapedDiagonalSegment(points []Point) int {
	if len(points) < 3 {
		return 0
	}

	mainDiagonals := make(map[int]diagExtremes)
	antiDiagonals := make(map[int]diagExtremes)

	for _, p := range points {
		c1 := p.X - p.Y
		if ext, ok := mainDiagonals[c1]; ok {
			ext.minCoord = min(ext.minCoord, p.X)
			ext.maxCoord = max(ext.maxCoord, p.X)
			mainDiagonals[c1] = ext
		} else {
			mainDiagonals[c1] = diagExtremes{minCoord: p.X, maxCoord: p.X}
		}

		c2 := p.X + p.Y
		if ext, ok := antiDiagonals[c2]; ok {
			ext.minCoord = min(ext.minCoord, p.X)
			ext.maxCoord = max(ext.maxCoord, p.X)
			antiDiagonals[c2] = ext
		} else {
			antiDiagonals[c2] = diagExtremes{minCoord: p.X, maxCoord: p.X}
		}
	}

	maxLen := 0

	for _, pj := range points {
		xj := pj.X
		c1 := pj.X - pj.Y
		c2 := pj.X + pj.Y

		len_ij_main := 0
		if ext, ok := mainDiagonals[c1]; ok {
			if ext.minCoord != ext.maxCoord {
				len_ij_main = max(abs(xj - ext.minCoord), abs(xj - ext.maxCoord))
			}
		}

		len_jk_anti := 0
		if ext, ok := antiDiagonals[c2]; ok {
			if ext.minCoord != ext.maxCoord {
				len_jk_anti = max(abs(xj - ext.minCoord), abs(xj - ext.maxCoord))
			}
		}

		if len_ij_main > 0 && len_jk_anti > 0 {
			maxLen = max(maxLen, len_ij_main+len_jk_anti)
		}

		len_ij_anti := 0
		if ext, ok := antiDiagonals[c2]; ok {
			if ext.minCoord != ext.maxCoord {
				len_ij_anti = max(abs(xj - ext.minCoord), abs(xj - ext.maxCoord))
			}
		}

		len_jk_main := 0
		if ext, ok := mainDiagonals[c1]; ok {
			if ext.minCoord != ext.maxCoord {
				len_jk_main = max(abs(xj - ext.minCoord), abs(xj - ext.maxCoord))
			}
		}

		if len_ij_anti > 0 && len_jk_main > 0 {
			maxLen = max(maxLen, len_ij_anti+len_jk_main)
		}
	}

	return maxLen
}