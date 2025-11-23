func countVisitedNodes(n int, edges [][]int, start int) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
    }

    visited := make([]bool, n)
    var dfs func(int)
    dfs = func(node int) {
        visited[node] = true
        for _, neighbor := range graph[node] {
            if !visited[neighbor] {
                dfs(neighbor)
            }
        }
    }

    dfs(start)

    count := 0
    for _, v := range visited {
        if v {
            count++
        }
    }

    return count
}