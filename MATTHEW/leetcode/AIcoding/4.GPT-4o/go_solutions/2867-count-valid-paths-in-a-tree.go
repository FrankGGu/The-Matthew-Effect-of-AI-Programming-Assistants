package main

import "fmt"

var mod int = 1_000_000_007

func countValidPaths(n int, edges [][]int, start int, end int, maxMove int) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    dp := make([][][]int, n)
    for i := range dp {
        dp[i] = make([][]int, maxMove+1)
        for j := range dp[i] {
            dp[i][j] = make([]int, 2)
        }
    }

    dp[start][0][0] = 1

    for move := 0; move < maxMove; move++ {
        for node := 0; node < n; node++ {
            for _, neighbor := range graph[node] {
                dp[neighbor][move+1][0] = (dp[neighbor][move+1][0] + dp[node][move][0]) % mod
                dp[neighbor][move+1][1] = (dp[neighbor][move+1][1] + dp[node][move][1]) % mod
            }
        }
        dp[start][move+1][1] = (dp[start][move+1][1] + dp[start][move][0]) % mod
    }

    ans := 0
    for move := 0; move <= maxMove; move++ {
        ans = (ans + dp[end][move][1]) % mod
    }

    return ans
}

func main() {
    n := 7
    edges := [][]int{{0, 1}, {0, 2}, {1, 3}, {1, 4}, {2, 5}, {2, 6}}
    start := 0
    end := 4
    maxMove := 3
    fmt.Println(countValidPaths(n, edges, start, end, maxMove))
}