func numBusesToDestination(routes [][]int, source int, target int) int {
    if source == target {
        return 0
    }

    n := len(routes)
    adj := make([][]int, n)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if intersect(routes[i], routes[j]) {
                adj[i] = append(adj[i], j)
                adj[j] = append(adj[j], i)
            }
        }
    }

    queue := []int{}
    visited := make([]bool, n)
    for i := 0; i < n; i++ {
        for _, stop := range routes[i] {
            if stop == source {
                queue = append(queue, i)
                visited[i] = true
                break
            }
        }
    }

    steps := 1
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            bus := queue[0]
            queue = queue[1:]

            for _, stop := range routes[bus] {
                if stop == target {
                    return steps
                }
            }

            for _, nextBus := range adj[bus] {
                if !visited[nextBus] {
                    queue = append(queue, nextBus)
                    visited[nextBus] = true
                }
            }
        }
        steps++
    }

    return -1
}

func intersect(route1 []int, route2 []int) bool {
    set := make(map[int]bool)
    for _, stop := range route1 {
        set[stop] = true
    }
    for _, stop := range route2 {
        if set[stop] {
            return true
        }
    }
    return false
}