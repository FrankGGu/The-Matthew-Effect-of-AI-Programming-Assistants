package main

import "fmt"

func maximumGeneticDifferenceQuery(parents []int, queries [][]int) []int {
    n := len(parents)
    graph := make([][]int, n)
    for i, p := range parents {
        if p != -1 {
            graph[p] = append(graph[p], i)
        }
    }

    maxVal := make([]int, n)
    for i := 0; i < n; i++ {
        maxVal[i] = i
    }

    var dfs func(int)
    dfs = func(node int) {
        for _, child := range graph[node] {
            dfs(child)
            maxVal[node] = max(maxVal[node], maxVal[child])
        }
    }

    dfs(0)

    results := make([]int, len(queries))
    for i, q := range queries {
        results[i] = maxVal[q[0]] ^ maxVal[q[1]]
    }

    return results
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    parents := []int{-1, 0, 0, 1, 1, 2}
    queries := [][]int{{0, 1}, {1, 2}, {2, 3}, {1, 4}}
    result := maximumGeneticDifferenceQuery(parents, queries)
    fmt.Println(result)
}