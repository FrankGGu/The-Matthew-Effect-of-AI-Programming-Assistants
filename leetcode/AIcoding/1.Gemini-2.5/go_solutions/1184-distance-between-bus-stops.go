import "math"

func distanceBetweenBusStops(distance []int, start int, destination int) int {
	if start == destination {
		return 0
	}

	totalDistance := 0
	for _, dist := range distance {
		totalDistance += dist
	}

	path1Distance := 0
	minIdx := int(math.Min(float64(start), float64(destination)))
	maxIdx := int(math.Max(float64(start), float64(destination)))

	for i := minIdx; i < maxIdx; i++ {
		path1Distance += distance[i]
	}

	path2Distance := totalDistance - path1Distance

	return int(math.Min(float64(path1Distance), float64(path2Distance)))
}