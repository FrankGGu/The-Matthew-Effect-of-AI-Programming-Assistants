import "math"

func distance(x1, y1, x2, y2 float64) float64 {
	return math.Sqrt(math.Pow(x2-x1, 2) + math.Pow(y2-y1, 2))
}

func checkOverlap(radius int, xCenter int, yCenter int, x1 int, y1 int, x2 int, y2 int) bool {
	closestX := float64(xCenter)
	closestY := float64(yCenter)

	if float64(xCenter) < float64(x1) {
		closestX = float64(x1)
	} else if float64(xCenter) > float64(x2) {
		closestX = float64(x2)
	}

	if float64(yCenter) < float64(y1) {
		closestY = float64(y1)
	} else if float64(yCenter) > float64(y2) {
		closestY = float64(y2)
	}

	dist := distance(float64(xCenter), float64(yCenter), closestX, closestY)

	return dist <= float64(radius)
}