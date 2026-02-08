package main

func maximumArea(rectangles [][]int) int {
	maxDiagonalSquared := 0
	maxArea := 0

	for _, rect := range rectangles {
		l := rect[0]
		w := rect[1]

		currentDiagonalSquared := l*l + w*w
		currentArea := l * w

		if currentDiagonalSquared > maxDiagonalSquared {
			maxDiagonalSquared = currentDiagonalSquared
			maxArea = currentArea
		} else if currentDiagonalSquared == maxDiagonalSquared {
			if currentArea > maxArea {
				maxArea = currentArea
			}
		}
	}

	return maxArea
}