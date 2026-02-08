func numBusesToDestination(routes [][]int, S int, T int) int {
    if S == T {
        return 0
    }

    graph := make(map[int][]int)
    for i, route := range routes {
        for _, stop := range route {
            graph[stop] = append(graph[stop], i)
        }
    }

    queue := []int{S}
    visited := make(map[int]bool)
    visited[S] = true
    buses := 0

    for len(queue) > 0 {
        buses++
        nextQueue := []int{}
        for _, stop := range queue {
            for _, bus := range graph[stop] {
                for _, nextStop := range routes[bus] {
                    if nextStop == T {
                        return buses
                    }
                    if !visited[nextStop] {
                        visited[nextStop] = true
                        nextQueue = append(nextQueue, nextStop)
                    }
                }
            }
        }
        queue = nextQueue
    }

    return -1
}