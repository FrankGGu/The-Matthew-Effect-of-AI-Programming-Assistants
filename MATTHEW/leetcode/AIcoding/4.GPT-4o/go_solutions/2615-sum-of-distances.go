func sumOfDistancesInTree(N int, edges [][]int) []int {
    graph := make([][]int, N)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    res := make([]int, N)
    count := make([]int, N)
    ans := 0

    var dfs1 func(node, parent int)
    dfs1 = func(node, parent int) {
        count[node] = 1
        for _, neighbor := range graph[node] {
            if neighbor != parent {
                dfs1(neighbor, node)
                count[node] += count[neighbor]
                ans += count[neighbor]
            }
        }
    }

    var dfs2 func(node, parent int)
    dfs2 = func(node, parent int) {
        for _, neighbor := range graph[node] {
            if neighbor != parent {
                res[neighbor] = res[node] - count[neighbor] + (N - count[neighbor])
                dfs2(neighbor, node)
            }
        }
    }

    dfs1(0, -1)
    res[0] = ans
    dfs2(0, -1)

    return res
}