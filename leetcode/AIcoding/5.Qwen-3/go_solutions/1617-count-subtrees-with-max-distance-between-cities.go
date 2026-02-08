package main

func countSubtrees(n int, edges [][]int) []int {
    graph := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    result := make([]int, n)

    var dfs func(int, int) [2]int
    dfs = func(node, parent int) [2]int {
        maxDist := 0
        count := 1
        for _, child := range graph[node] {
            if child == parent {
                continue
            }
            sub := dfs(child, node)
            if sub[0]+1 > maxDist {
                maxDist = sub[0] + 1
            }
            count += sub[1]
        }
        result[maxDist-1]++
        return [2]int{maxDist, count}
    }

    dfs(0, -1)
    return result
}