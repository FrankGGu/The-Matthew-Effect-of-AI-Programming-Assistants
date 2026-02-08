package main

func findChampion(n int, edges [][]int) int {
    inDegree := make([]int, n)
    graph := make([][]int, n)

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        inDegree[v]++
    }

    var queue []int
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    count := 0
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        count++
        for _, neighbor := range graph[node] {
            inDegree[neighbor]--
            if inDegree[neighbor] == 0 {
                queue = append(queue, neighbor)
            }
        }
    }

    if count == n {
        return -1
    }

    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            return i
        }
    }

    return -1
}