func distanceBetweenBusStops(distance []int, start int, destination int) int {
    if start > destination {
        start, destination = destination, start
    }
    totalDistance := 0
    for _, d := range distance {
        totalDistance += d
    }
    directDistance := 0
    for i := start; i < destination; i++ {
        directDistance += distance[i]
    }
    return min(directDistance, totalDistance-directDistance)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}