func largestRectangleArea(heights []int) int {
	n := len(heights)
	if n == 0 {
		return 0
	}

	maxArea := 0
	stack := []int{}

	for i := 0; i <= n; i++ {
		currHeight := 0
		if i < n {
			currHeight = heights[i]
		}

		for len(stack) > 0 && currHeight < heights[stack[len(stack)-1]] {
			top := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			height := heights[top]
			width := i
			if len(stack) > 0 {
				width = i - stack[len(stack)-1] - 1
			}
			maxArea = max(maxArea, height*width)
		}
		stack = append(stack, i)
	}

	return maxArea
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}