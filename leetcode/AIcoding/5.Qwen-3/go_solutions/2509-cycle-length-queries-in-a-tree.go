package main

func cycleLengthQueries(parent []int, queries [][]int) []int {
    res := make([]int, len(queries))
    for i := range queries {
        u, v := queries[i][0], queries[i][1]
        length := 0
        visited := make(map[int]bool)
        for u != v {
            if visited[u] {
                break
            }
            visited[u] = true
            u = parent[u]
            length++
            if visited[v] {
                break
            }
            visited[v] = true
            v = parent[v]
            length++
        }
        res[i] = length
    }
    return res
}