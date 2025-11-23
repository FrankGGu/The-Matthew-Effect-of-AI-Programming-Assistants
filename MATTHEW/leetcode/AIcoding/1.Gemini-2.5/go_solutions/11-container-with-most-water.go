package main

import "math"

func maxArea(height []int) int {
	left := 0
	right := len(height) - 1
	maxAreaVal := 0

	for left < right {
		currentHeight := int(math.Min(float64(height[left]), float64(height[right])))
		width := right - left
		currentArea := currentHeight * width
		maxAreaVal = int(math.Max(float64(maxAreaVal), float64(currentArea)))

		if height[left] < height[right] {
			left++
		} else {
			right--
		}
	}

	return maxAreaVal
}