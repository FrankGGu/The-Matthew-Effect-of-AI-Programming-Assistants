package main

import (
    "fmt"
)

func countSubTrees(n int, edges [][]int, labels string) []int {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    res := make([]int, n)
    count := make([][]int, n)
    for i := range count {
        count[i] = make([]int, 26)
    }

    var dfs func(node, parent int) []int
    dfs = func(node, parent int) []int {
        labelIndex := labels[node] - 'a'
        count[node][labelIndex]++

        for _, neighbor := range graph[node] {
            if neighbor != parent {
                childCount := dfs(neighbor, node)
                for i := 0; i < 26; i++ {
                    count[node][i] += childCount[i]
                }
            }
        }

        res[node] = count[node][labelIndex]
        return count[node]
    }

    dfs(0, -1)
    return res
}

func main() {
    n := 7
    edges := [][]int{{0, 1}, {0, 2}, {1, 3}, {1, 4}, {2, 5}, {2, 6}}
    labels := "abaedcd"
    fmt.Println(countSubTrees(n, edges, labels))
}