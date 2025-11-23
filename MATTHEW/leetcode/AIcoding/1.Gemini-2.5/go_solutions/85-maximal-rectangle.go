func largestRectangleArea(heights []int) int {
	maxArea := 0
	stack := []int{} // stores indices

	// Append 0 to heights to ensure all bars are processed
	heights = append(heights, 0)

	for i, h := range heights {
		for len(stack) > 0 && heights[stack[len(stack)-1]] >= h {
			height := heights[stack[len(stack)-1]]
			stack = stack[:len(stack)-1] // Pop

			width := i
			if len(stack) > 0 {
				width = i - stack[len(stack)-1] - 1
			}

			currentArea := height * width
			if currentArea > maxArea {
				maxArea = currentArea
			}
		}
		stack = append(stack, i) // Push
	}
	return maxArea
}

func maximalRectangle(matrix [][]byte) int {
	if len(matrix) == 0 || len(matrix[0]) == 0 {
		return 0
	}

	rows := len(matrix)
	cols := len(matrix[0])
	maxArea := 0
	heights := make([]int, cols) // Stores the current histogram heights for each column

	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			if matrix[i][j] == '1' {
				heights[j]++
			} else {
				heights[j] = 0
			}
		}
		// Calculate the largest rectangle in the current histogram
		currentMaxArea := largestRectangleArea(heights)
		if currentMaxArea > maxArea {
			maxArea = currentMaxArea
		}
	}
	return maxArea
}