func distanceBetweenBusStops(distance []int, start int, destination int) int {
	n := len(distance)
	clockwise := 0
	counterClockwise := 0

	i := start
	for i != destination {
		clockwise += distance[i]
		i = (i + 1) % n
	}

	i = start
	for i != destination {
		counterClockwise += distance[(i + n - 1) % n]
		i = (i + n - 1) % n
	}

	if clockwise < counterClockwise {
		return clockwise
	}
	return counterClockwise
}