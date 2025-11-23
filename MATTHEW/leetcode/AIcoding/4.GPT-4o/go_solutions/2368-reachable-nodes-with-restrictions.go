func reachableNodes(edges [][]int, restricted []int) int {
    graph := make(map[int][]int)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    restrictedSet := make(map[int]struct{})
    for _, r := range restricted {
        restrictedSet[r] = struct{}{}
    }

    visited := make(map[int]struct{})
    var dfs func(node int)
    dfs = func(node int) {
        if _, ok := visited[node]; ok {
            return
        }
        visited[node] = struct{}{}
        for _, neighbor := range graph[node] {
            if _, ok := restrictedSet[neighbor]; !ok {
                dfs(neighbor)
            }
        }
    }

    dfs(0)
    return len(visited)
}