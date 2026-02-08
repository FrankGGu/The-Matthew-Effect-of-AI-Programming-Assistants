func minimumReverseOperations(n int, edges [][]int, start int, goal int) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    queue := []int{start}
    distance := make([]int, n)
    for i := range distance {
        distance[i] = -1
    }
    distance[start] = 0

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]

        for _, neighbor := range graph[current] {
            if distance[neighbor] == -1 {
                distance[neighbor] = distance[current] + 1
                queue = append(queue, neighbor)
            }
        }
    }

    if distance[goal] == -1 {
        return -1
    }

    return distance[goal]
}