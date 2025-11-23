package main

func maximumStarSum(peak []int, edges [][]int) int {
    graph := make([][]int, len(peak))
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    maxSum := 0
    visited := make([]bool, len(peak))

    var dfs func(int) int
    dfs = func(node int) int {
        if visited[node] {
            return 0
        }
        visited[node] = true
        sum := peak[node]
        for _, neighbor := range graph[node] {
            sum += dfs(neighbor)
        }
        return sum
    }

    for i := 0; i < len(peak); i++ {
        if !visited[i] {
            currentSum := dfs(i)
            if currentSum > maxSum {
                maxSum = currentSum
            }
        }
    }

    return maxSum
}