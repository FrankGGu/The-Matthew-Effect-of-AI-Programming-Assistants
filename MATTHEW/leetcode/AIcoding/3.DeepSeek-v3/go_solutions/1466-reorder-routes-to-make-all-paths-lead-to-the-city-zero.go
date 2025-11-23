func minReorder(n int, connections [][]int) int {
    graph := make(map[int][]int)
    reverseGraph := make(map[int][]int)
    for _, conn := range connections {
        u, v := conn[0], conn[1]
        graph[u] = append(graph[u], v)
        reverseGraph[v] = append(reverseGraph[v], u)
    }

    visited := make([]bool, n)
    queue := []int{0}
    visited[0] = true
    res := 0

    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]

        for _, v := range graph[u] {
            if !visited[v] {
                res++
                visited[v] = true
                queue = append(queue, v)
            }
        }

        for _, v := range reverseGraph[u] {
            if !visited[v] {
                visited[v] = true
                queue = append(queue, v)
            }
        }
    }

    return res
}