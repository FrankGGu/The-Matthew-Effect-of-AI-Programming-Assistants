package main

func minAreaRect(image [][]int) int {
	if len(image) == 0 || len(image[0]) == 0 {
		return 0
	}

	rows := make(map[int]struct{})
	cols := make(map[int]struct{})

	for i := 0; i < len(image); i++ {
		for j := 0; j < len(image[0]); j++ {
			if image[i][j] == 1 {
				rows[i] = struct{}{}
				cols[j] = struct{}{}
			}
		}
	}

	var rowSlice []int
	for r := range rows {
		rowSlice = append(rowSlice, r)
	}

	var colSlice []int
	for c := range cols {
		colSlice = append(colSlice, c)
	}

	minArea := math.MaxInt32

	for i := 0; i < len(rowSlice); i++ {
		for j := i + 1; j < len(rowSlice); j++ {
			row1 := rowSlice[i]
			row2 := rowSlice[j]
			count := 0
			for k := 0; k < len(colSlice); k++ {
				col := colSlice[k]
				if image[row1][col] == 1 && image[row2][col] == 1 {
					count++
				}
			}
			if count >= 2 {
				area := (row2 - row1) * (colSlice[len(colSlice)-1] - colSlice[0])
				if area < minArea {
					minArea = area
				}
			}
		}
	}

	if minArea == math.MaxInt32 {
		return 0
	}

	return minArea
}