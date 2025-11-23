import "math"

func bestCoordinate(towers [][]int, radius int) []int {
	maxX, maxY := 0, 0
	for _, tower := range towers {
		maxX = max(maxX, tower[0])
		maxY = max(maxY, tower[1])
	}

	bestX, bestY, maxQuality := 0, 0, 0

	for x := 0; x <= maxX; x++ {
		for y := 0; y <= maxY; y++ {
			quality := 0
			for _, tower := range towers {
				distance := math.Sqrt(float64((x-tower[0])*(x-tower[0]) + (y-tower[1])*(y-tower[1])))
				if distance <= float64(radius) {
					quality += int(float64(tower[2]) / (1 + distance))
				}
			}

			if quality > maxQuality {
				maxQuality = quality
				bestX, bestY = x, y
			}
		}
	}

	return []int{bestX, bestY}
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}