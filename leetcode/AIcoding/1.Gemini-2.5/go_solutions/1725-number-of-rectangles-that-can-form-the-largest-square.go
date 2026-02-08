package main

func countGoodRectangles(rectangles [][]int) int {
	maxSquareSide := 0
	for _, rect := range rectangles {
		l := rect[0]
		w := rect[1]
		currentMin := l
		if w < l {
			currentMin = w
		}
		if currentMin > maxSquareSide {
			maxSquareSide = currentMin
		}
	}

	count := 0
	for _, rect := range rectangles {
		l := rect[0]
		w := rect[1]
		currentMin := l
		if w < l {
			currentMin = w
		}
		if currentMin == maxSquareSide {
			count++
		}
	}

	return count
}