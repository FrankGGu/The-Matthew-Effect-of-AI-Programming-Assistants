func sumOfDistancesInTree(n int, edges [][]int) []int {
    graph := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    count := make([]int, n)
    res := make([]int, n)

    var postOrder func(node, parent int)
    postOrder = func(node, parent int) {
        for _, child := range graph[node] {
            if child != parent {
                postOrder(child, node)
                count[node] += count[child]
                res[node] += res[child] + count[child]
            }
        }
        count[node]++
    }

    var preOrder func(node, parent int)
    preOrder = func(node, parent int) {
        for _, child := range graph[node] {
            if child != parent {
                res[child] = res[node] - count[child] + (n - count[child])
                preOrder(child, node)
            }
        }
    }

    postOrder(0, -1)
    preOrder(0, -1)

    return res
}