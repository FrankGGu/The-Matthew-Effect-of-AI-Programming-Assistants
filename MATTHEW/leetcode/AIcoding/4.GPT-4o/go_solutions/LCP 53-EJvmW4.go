func guardSpaceCity(n int, edges [][]int) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    visited := make([]bool, n)
    var countGuard func(node int) int
    countGuard = func(node int) int {
        visited[node] = true
        guards := 0
        for _, neighbor := range graph[node] {
            if !visited[neighbor] {
                guards += countGuard(neighbor)
            }
        }
        return guards + 1
    }

    totalGuards := 0
    for i := 0; i < n; i++ {
        if !visited[i] {
            totalGuards += countGuard(i)
        }
    }

    return totalGuards
}