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

    visitedRoutes := make(map[int]bool)
    visitedStops := make(map[int]bool)
    queue := []int{source}
    buses := 0

    for len(queue) > 0 {
        size := len(queue)
        buses++
        for i := 0; i < size; i++ {
            currentStop := queue[i]
            for _, routeIdx := range stopToRoutes[currentStop] {
                if visitedRoutes[routeIdx] {
                    continue
                }
                visitedRoutes[routeIdx] = true
                for _, stop := range routes[routeIdx] {
                    if stop == target {
                        return buses
                    }
                    if !visitedStops[stop] {
                        visitedStops[stop] = true
                        queue = append(queue, stop)
                    }
                }
            }
        }
        queue = queue[size:]
    }

    return -1
}