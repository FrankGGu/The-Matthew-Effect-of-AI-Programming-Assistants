package main

func maxPathQuality(owners []int, maxTime int, edges [][]int) int {
    graph := make(map[int]map[int]int)
    for _, edge := range edges {
        u, v, w := edge[0], edge[1], edge[2]
        if _, ok := graph[u]; !ok {
            graph[u] = make(map[int]int)
        }
        if _, ok := graph[v]; !ok {
            graph[v] = make(map[int]int)
        }
        graph[u][v] = w
        graph[v][u] = w
    }

    maxQuality := 0
    visited := make(map[int]bool)
    var dfs func(node int, time int, quality int)
    dfs = func(node int, time int, quality int) {
        if time > maxTime {
            return
        }
        if node == owners[0] {
            if quality > maxQuality {
                maxQuality = quality
            }
        }
        visited[node] = true
        for neighbor, weight := range graph[node] {
            if !visited[neighbor] {
                dfs(neighbor, time+weight, quality+owners[neighbor])
            }
        }
        visited[node] = false
    }

    dfs(owners[0], 0, owners[0])
    return maxQuality
}