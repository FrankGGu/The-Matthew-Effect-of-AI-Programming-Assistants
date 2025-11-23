package main

func getAncestors(n int, edges [][]int) [][]int {
    graph := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[v] = append(graph[v], u)
    }

    result := make([][]int, n)
    for i := 0; i < n; i++ {
        visited := make(map[int]bool)
        stack := []int{i}
        for len(stack) > 0 {
            node := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            for _, neighbor := range graph[node] {
                if !visited[neighbor] {
                    visited[neighbor] = true
                    stack = append(stack, neighbor)
                }
            }
        }
        var ancestors []int
        for k := range visited {
            ancestors = append(ancestors, k)
        }
        sort.Ints(ancestors)
        result[i] = ancestors
    }
    return result
}