import "math"

func numBusesToDestination(routes [][]int, S int, T int) int {
    if S == T {
        return 0
    }

    busMap := make(map[int][]int)
    for i, route := range routes {
        for _, stop := range route {
            busMap[stop] = append(busMap[stop], i)
        }
    }

    queue := []int{S}
    visitedStops := map[int]bool{S: true}
    visitedBuses := make([]bool, len(routes))
    buses := 0

    for len(queue) > 0 {
        buses++
        nextQueue := []int{}
        for _, stop := range queue {
            for _, bus := range busMap[stop] {
                if !visitedBuses[bus] {
                    visitedBuses[bus] = true
                    for _, nextStop := range routes[bus] {
                        if nextStop == T {
                            return buses
                        }
                        if !visitedStops[nextStop] {
                            visitedStops[nextStop] = true
                            nextQueue = append(nextQueue, nextStop)
                        }
                    }
                }
            }
        }
        queue = nextQueue
    }
    return -1
}