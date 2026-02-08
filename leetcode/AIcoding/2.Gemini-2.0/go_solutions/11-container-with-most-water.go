func maxArea(height []int) int {
	left := 0
	right := len(height) - 1
	maxArea := 0

	for left < right {
		width := right - left
		currentHeight := 0
		if height[left] < height[right] {
			currentHeight = height[left]
			left++
		} else {
			currentHeight = height[right]
			right--
		}

		area := width * currentHeight
		if area > maxArea {
			maxArea = area
		}
	}

	return maxArea
}