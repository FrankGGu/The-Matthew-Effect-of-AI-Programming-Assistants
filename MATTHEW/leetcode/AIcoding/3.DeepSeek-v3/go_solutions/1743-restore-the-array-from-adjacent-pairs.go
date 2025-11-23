func restoreArray(adjacentPairs [][]int) []int {
    graph := make(map[int][]int)
    for _, pair := range adjacentPairs {
        u, v := pair[0], pair[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    var start int
    for num, neighbors := range graph {
        if len(neighbors) == 1 {
            start = num
            break
        }
    }

    n := len(adjacentPairs) + 1
    res := make([]int, n)
    res[0] = start
    res[1] = graph[start][0]
    for i := 2; i < n; i++ {
        prev := res[i-1]
        candidates := graph[prev]
        if candidates[0] == res[i-2] {
            res[i] = candidates[1]
        } else {
            res[i] = candidates[0]
        }
    }
    return res
}