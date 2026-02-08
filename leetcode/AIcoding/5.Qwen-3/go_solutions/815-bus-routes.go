package main

func numBusesToDestination(routes [][]int, source int, target int) int {
    if source == target {
        return 0
    }

    // Build a map from stop to the list of bus routes that go through it
    stopToRoutes := make(map[int][]int)
    for i, route := range routes {
        for _, stop := range route {
            stopToRoutes[stop] = append(stopToRoutes[stop], i)
        }
    }

    // BFS setup
    visitedStops := make(map[int]bool)
    visitedRoutes := make(map[int]bool)
    queue := []int{source}
    visitedStops[source] = true

    buses := 0

    for len(queue) > 0 {
        nextQueue := []int{}
        for _, stop := range queue {
            for _, route := range stopToRoutes[stop] {
                if visitedRoutes[route] {
                    continue
                }
                visitedRoutes[route] = true
                for _, nextStop := range routes[route] {
                    if !visitedStops[nextStop] {
                        if nextStop == target {
                            return buses + 1
                        }
                        visitedStops[nextStop] = true
                        nextQueue = append(nextQueue, nextStop)
                    }
                }
            }
        }
        queue = nextQueue
        buses++
    }

    return -1
}