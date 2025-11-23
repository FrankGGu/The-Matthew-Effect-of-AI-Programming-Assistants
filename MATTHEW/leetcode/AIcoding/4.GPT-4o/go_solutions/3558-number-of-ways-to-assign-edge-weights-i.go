func countWays(n int, edges [][]int) int {
    const mod = 1_000_000_007
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]-1] = append(graph[edge[0]-1], edge[1]-1)
        graph[edge[1]-1] = append(graph[edge[1]-1], edge[0]-1)
    }

    visited := make([]bool, n)
    var dfs func(node int) int
    dfs = func(node int) int {
        visited[node] = true
        count := 1
        for _, neighbor := range graph[node] {
            if !visited[neighbor] {
                count += dfs(neighbor)
            }
        }
        return count
    }

    totalWays := 1
    for i := 0; i < n; i++ {
        if !visited[i] {
            componentSize := dfs(i)
            totalWays = (totalWays * 2) % mod
        }
    }

    return totalWays
}