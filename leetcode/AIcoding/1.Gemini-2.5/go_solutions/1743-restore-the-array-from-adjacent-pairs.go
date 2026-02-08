func restoreArray(adjacentPairs [][]int) []int {
    graph := make(map[int][]int)
    for _, pair := range adjacentPairs {
        u, v := pair[0], pair[1]
        graph[u] = append(graph[u], v)
        graph[v]