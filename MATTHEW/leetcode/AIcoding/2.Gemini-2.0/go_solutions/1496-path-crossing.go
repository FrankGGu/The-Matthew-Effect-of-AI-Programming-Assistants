func isPathCrossing(path string) bool {
	visited := make(map[string]bool)
	x, y := 0, 0
	visited["0,0"] = true
	for _, move := range path {
		switch move {
		case 'N':
			y++
		case 'S':
			y--
		case 'E':
			x++
		case 'W':
			x--
		}
		key := string(rune(x) + '0') + "," + string(rune(y) + '0')
		if visited[key] {
			return true
		}
		visited[key] = true
	}
	return false
}