func shortestPathLength(graph [][]int) int {
    n := len(graph)
    if n == 1 {
        return 0
    }

    finalState := (1 << n) - 1
    queue := make([][2]int, 0)
    visited := make(map[[2]int]bool)

    for i := 0; i < n; i++ {
        queue = append(queue, [2]int{i, 1 << i})
        visited[[2]int{i, 1 << i}] = true
    }

    steps := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]
            node := current[0]
            state := current[1]

            for _, neighbor := range graph[node] {
                newState := state | (1 << neighbor)
                if newState == finalState {
                    return steps + 1
                }
                if !visited[[2]int{neighbor, newState}] {
                    visited[[2]int{neighbor, newState}] = true
                    queue = append(queue, [2]int{neighbor, newState})
                }
            }
        }
        steps++
    }

    return -1
}