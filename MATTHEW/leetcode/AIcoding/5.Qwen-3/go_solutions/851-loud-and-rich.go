package main

func loudAndRich(roads [][]int, names []string) []string {
    n := len(names)
    graph := make([][]int, n)
    inDegree := make([]int, n)
    for _, road := range roads {
        u, v := road[0], road[1]
        graph[u] = append(graph[u], v)
        inDegree[v]++
    }

    result := make([]string, n)
    queue := make([]int, 0)
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        result[u] = names[u]
        for _, v := range graph[u] {
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    return result
}