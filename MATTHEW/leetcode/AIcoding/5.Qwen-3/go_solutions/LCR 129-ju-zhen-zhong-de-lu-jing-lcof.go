package main

func isPathCrossing(s string) bool {
	visited := make(map[[2]int]bool)
	visited[[2]int{0, 0}] = true
	x, y := 0, 0
	for _, c := range s {
		switch c {
		case 'N':
			y++
		case 'S':
			y--
		case 'E':
			x++
		case 'W':
			x--
		}
		if visited[[2]int{x, y}] {
			return true
		}
		visited[[2]int{x, y}] = true
	}
	return false
}