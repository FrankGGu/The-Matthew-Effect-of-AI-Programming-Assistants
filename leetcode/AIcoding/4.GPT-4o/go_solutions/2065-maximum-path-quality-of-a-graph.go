package main

import (
    "math"
)

func maximumPathQuality(edges [][]int, values []int, maxTime int) int {
    graph := make([][][]int, len(values))
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], []int{edge[1], edge[2]})
        graph[edge[1]] = append(graph[edge[1]], []int{edge[0], edge[2]})
    }

    var dfs func(node, time, quality int, visited []bool) int
    dfs = func(node, time, quality int, visited []bool) int {
        if time > maxTime {
            return 0
        }
        if node == 0 {
            return quality
        }

        visited[node] = true
        maxQuality := 0
        for _, neighbor := range graph[node] {
            nextNode, cost := neighbor[0], neighbor[1]
            if !visited[nextNode] {
                maxQuality = max(maxQuality, dfs(nextNode, time+cost, quality+values[nextNode], visited))
            }
        }
        visited[node] = false
        return maxQuality
    }

    visited := make([]bool, len(values))
    return dfs(0, 0, values[0], visited)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}