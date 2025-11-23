package main

func collectTheCoins(n int, edges [][]int) int {
    if n == 1 {
        return 0
    }
    adj := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    degree := make([]int, n)
    for i := 0; i < n; i++ {
        degree[i] = len(adj[i])
    }

    queue := []int{}
    for i := 0; i < n; i++ {
        if degree[i] == 1 {
            queue = append(queue, i)
        }
    }

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]
            for _, neighbor := range adj[node] {
                degree[neighbor]--
                if degree[neighbor] == 1 {
                    queue = append(queue, neighbor)
                }
            }
        }
    }

    result := 0
    for i := 0; i < n; i++ {
        if degree[i] > 0 {
            result++
        }
    }

    if result == 1 {
        return 0
    }
    return result - 1
}