func countUnreachablePairs(n int, edges [][]int) int64 {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    visited := make([]bool, n)
    var dfs func(node int) int64
    dfs = func(node int) int64 {
        visited[node] = true
        size := int64(1)
        for _, neighbor := range graph[node] {
            if !visited[neighbor] {
                size += dfs(neighbor)
            }
        }
        return size
    }

    totalPairs := int64(0)
    componentSizes := []int64{}

    for i := 0; i < n; i++ {
        if !visited[i] {
            size := dfs(i)
            componentSizes = append(componentSizes, size)
        }
    }

    totalNodes := int64(0)
    for _, size := range componentSizes {
        totalPairs += size * totalNodes
        totalNodes += size
    }

    return totalPairs
}