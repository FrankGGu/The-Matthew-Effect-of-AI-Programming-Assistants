func spiralMatrixIII(rows int, cols int, rStart int, cStart int) [][]int {
	total := rows * cols
	result := make([][]int, 0, total)
	result = append(result, []int{rStart, cStart})
	if len(result) == total {
		return result
	}

	dx := 0
	dy := 1
	length := 1
	for len(result) < total {
		for i := 0; i < 2; i++ {
			for j := 0; j < length; j++ {
				rStart += dx
				cStart += dy
				if rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols {
					result = append(result, []int{rStart, cStart})
				}
				if len(result) == total {
					return result
				}
			}
			dx, dy = dy, -dx
		}
		length++
	}
	return result
}