func numBusesToDestination(routes [][]int, source int, target int) int {
	if source == target {
		return 0
	}

	stopToRoutes := make(map[int][]int)
	for i, route := range routes {
		for _, stop := range route {
			stopToRoutes[stop] = append(stopToRoutes[stop], i)
		}
	}

	queue := []int{}
	visitedRoutes := make([]bool, len(routes))

	// Add all routes that pass through the source stop to the queue
	initialRoutes, ok := stopToRoutes[source]
	if !ok {
		// Source stop is not on any bus route, so target is unreachable
		return -1
	}

	for _, routeIdx := range initialRoutes {
		if !visitedRoutes[routeIdx] {
			queue = append(queue, routeIdx)
			visitedRoutes[routeIdx] = true
		}
	}

	if len(queue) == 0 {
		return -1
	}

	busCount := 1 // We've taken 1 bus so far

	for len(queue) > 0 {
		levelSize := len(queue)
		for k := 0; k < levelSize; k++ {
			currRouteIdx := queue[0]
			queue = queue[1:]

			for _, stop := range routes[currRouteIdx] {
				if stop == target {
					return busCount
				}

				// Find other routes that can be taken from this stop
				connectingRoutes, ok := stopToRoutes[stop]
				if !ok {
					continue
				}
				for _, nextRouteIdx := range connectingRoutes {
					if !visitedRoutes[nextRouteIdx] {
						visitedRoutes[nextRouteIdx] = true
						queue = append(queue, nextRouteIdx)
					}
				}
			}
		}
		busCount++
	}

	return -1 // Target is unreachable
}