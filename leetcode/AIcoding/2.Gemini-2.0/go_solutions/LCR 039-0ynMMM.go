func largestRectangleArea(heights []int) int {
	stack := []int{-1}
	maxArea := 0
	for i := 0; i < len(heights); i++ {
		for len(stack) > 1 && heights[i] < heights[stack[len(stack)-1]] {
			top := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			area := heights[top] * (i - stack[len(stack)-1] - 1)
			if area > maxArea {
				maxArea = area
			}
		}
		stack = append(stack, i)
	}
	for len(stack) > 1 {
		top := stack[len(stack)-1]
		stack = stack[:len(stack)-1]
		area := heights[top] * (len(heights) - stack[len(stack)-1] - 1)
		if area > maxArea {
			maxArea = area
		}
	}
	return maxArea
}