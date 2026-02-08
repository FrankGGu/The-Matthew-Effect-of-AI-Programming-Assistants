package main

func distanceBetweenBusStops(stops []int, start int, destination int) int {
	if start == destination {
		return 0
	}
	if start > destination {
		start, destination = destination, start
	}
	total := 0
	for i := 0; i < len(stops); i++ {
		total += stops[i]
	}
	sum1 := 0
	for i := start; i < destination; i++ {
		sum1 += stops[i]
	}
	sum2 := total - sum1
	return min(sum1, sum2)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}