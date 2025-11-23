import "math"

func escapeGhosts(ghosts [][]int, target []int) bool {
	distToTarget := manhattanDistance([]int{0, 0}, target)

	for _, ghost := range ghosts {
		ghostDist := manhattanDistance(ghost, target)
		if ghostDist <= distToTarget {
			return false
		}
	}

	return true
}

func manhattanDistance(p1 []int, p2 []int) int {
	return int(math.Abs(float64(p1[0]-p2[0])) + math.Abs(float64(p1[1]-p2[1])))
}