import (
	"fmt"
	"math"
)

func maxDistance(points [][]int) float64 {
	minX, maxX := math.Inf(1), math.Inf(-1)
	minY, maxY := math.Inf(1), math.Inf(-1)

	for _, p := range points {
		x, y := float64(p[0]), float64(p[1])
		minX = math.Min(minX, x)
		maxX = math.Max(maxX, x)
		minY = math.Min(minY, y)
		maxY = math.Max(maxY, y)
	}

	return math.Max(maxX-minX, maxY-minY)
}