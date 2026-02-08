package main

func largestRectangleArea(heights []int) int {
	maxArea := 0
	stack := []int{} // Stores indices of bars in increasing order of height

	n := len(heights)

	for i := 0; i <= n; i++ {
		currentHeight := 0
		if i < n {
			currentHeight = heights[i]
		}

		for len(stack) > 0 && currentHeight < heights[stack[len(stack)-1]] {
			hIndex := stack[len(stack)-1]
			stack = stack[:len(stack)-1] // Pop

			h := heights[hIndex]

			width := 0
			if len(stack) == 0 {
				// If stack is empty, this popped bar is the smallest till 'i',
				// so its width extends from index 0 up to 'i-1'.
				width = i
			} else {
				// If stack is not empty, the bar at stack.top() is the first bar
				// to the left that is smaller than 'h'.
				// So, width is from stack.top() + 1 up to 'i-1'.
				width = i - stack[len(stack)-1] - 1
			}

			area := h * width
			if area > maxArea {
				maxArea = area
			}
		}
		stack = append(stack, i) // Push current index onto the stack
	}

	return maxArea
}