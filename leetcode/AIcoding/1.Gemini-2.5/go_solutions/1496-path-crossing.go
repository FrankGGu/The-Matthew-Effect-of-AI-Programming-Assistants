package main

type Point struct {
	X int
	Y int
}

func isPathCrossing(path string) bool {
	visited := make(map[Point]bool)
	currentX, currentY := 0, 0

	visited[Point{currentX, currentY}] = true

	for _, move := range path {
		switch move {
		case 'N':
			currentY++
		case 'S':
			currentY--
		case 'E':
			currentX++
		case 'W':
			currentX--
		}

		newPoint := Point{currentX, currentY}

		if visited[newPoint] {
			return true
		}

		visited[newPoint] = true
	}

	return false
}