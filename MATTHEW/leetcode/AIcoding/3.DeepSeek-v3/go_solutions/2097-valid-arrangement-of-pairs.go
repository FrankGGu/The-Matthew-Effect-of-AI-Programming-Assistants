func validArrangement(pairs [][]int) [][]int {
    graph := make(map[int][]int)
    inDegree := make(map[int]int)
    outDegree := make(map[int]int)

    for _, pair := range pairs {
        u, v := pair[0], pair[1]
        graph[u] = append(graph[u], v)
        outDegree[u]++
        inDegree[v]++
    }

    start := pairs[0][0]
    for u := range outDegree {
        if outDegree[u] - inDegree[u] == 1 {
            start = u
            break
        }
    }

    var path []int
    stack := []int{start}

    for len(stack) > 0 {
        u := stack[len(stack)-1]
        if len(graph[u]) > 0 {
            v := graph[u][len(graph[u])-1]
            graph[u] = graph[u][:len(graph[u])-1]
            stack = append(stack, v)
        } else {
            path = append(path, u)
            stack = stack[:len(stack)-1]
        }
    }

    for i, j := 0, len(path)-1; i < j; i, j = i+1, j-1 {
        path[i], path[j] = path[j], path[i]
    }

    result := make([][]int, len(path)-1)
    for i := 0; i < len(path)-1; i++ {
        result[i] = []int{path[i], path[i+1]}
    }

    return result
}