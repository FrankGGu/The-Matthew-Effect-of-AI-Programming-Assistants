func loudAndRich(richer [][]int, quiet []int) []int {
    n := len(quiet)
    graph := make([][]int, n)
    inDegree := make([]int, n)
    for _, r := range richer {
        a, b := r[0], r[1]
        graph[a] = append(graph[a], b)
        inDegree[b]++
    }

    queue := make([]int, 0)
    res := make([]int, n)
    for i := 0; i < n; i++ {
        res[i] = i
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        for _, v := range graph[u] {
            if quiet[res[u]] < quiet[res[v]] {
                res[v] = res[u]
            }
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }
    return res
}