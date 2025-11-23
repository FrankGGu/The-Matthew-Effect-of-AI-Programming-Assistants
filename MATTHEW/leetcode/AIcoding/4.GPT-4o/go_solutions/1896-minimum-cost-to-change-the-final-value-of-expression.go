func minCost(expr string, values []int, edges [][]int) int {
    n := len(values)
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    type State struct {
        node  int
        value int
    }

    queue := []State{{0, values[0]}}
    visited := make([]bool, n)
    visited[0] = true
    totalCost := 0

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]

        if current.value == 1 {
            totalCost += 1
        }

        for _, neighbor := range graph[current.node] {
            if !visited[neighbor] {
                visited[neighbor] = true
                queue = append(queue, State{neighbor, values[neighbor]})
            }
        }
    }

    return totalCost
}