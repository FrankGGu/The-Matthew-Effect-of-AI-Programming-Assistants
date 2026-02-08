package main

import "fmt"

func maximumScore(nums []int, edges [][]int) int {
    n := len(nums)
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    maxScore := 0
    var dfs func(node, parent, score int)
    dfs = func(node, parent, score int) {
        score += nums[node]
        if len(graph[node]) == 1 && node != 0 {
            maxScore = max(maxScore, score)
            return
        }
        for _, neighbor := range graph[node] {
            if neighbor != parent {
                dfs(neighbor, node, score)
            }
        }
    }
    dfs(0, -1, 0)
    return maxScore
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{1, 2, 3, 4, 5}
    edges := [][]int{{0, 1}, {1, 2}, {2, 3}, {3, 4}}
    fmt.Println(maximumScore(nums, edges))
}