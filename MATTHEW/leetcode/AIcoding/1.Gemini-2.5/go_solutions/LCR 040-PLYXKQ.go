package main

func maximalRectangle(matrix [][]byte) int {
	if len(matrix) == 0 || len(matrix[0]) == 0 {
		return 0
	}

	m := len(matrix)
	n := len(matrix[0])
	maxArea := 0
	heights := make([]int, n)

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if matrix[i][j] == '1' {
				heights[j]++
			} else {
				heights[j] = 0
			}
		}
		maxArea = max(maxArea, largestRectangleArea(heights))
	}

	return maxArea
}

func largestRectangleArea(heights []int) int {
	n := len(heights)
	maxA := 0
	stack := []int{} // stores indices

	for i := 0; i <= n; i++ {
		currentHeight := 0
		if i < n {
			currentHeight = heights[i]
		}

		for len(stack) > 0 && currentHeight < heights[stack[len(stack)-1]] {
			h := heights[stack[len(stack)-1]]
			stack = stack[:len(stack)-1]

			width := i
			if len(stack) > 0 {
				width = i - stack[len(stack)-1] - 1
			}
			maxA = max(maxA, h*width)
		}
		stack = append(stack, i)
	}
	return maxA
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}