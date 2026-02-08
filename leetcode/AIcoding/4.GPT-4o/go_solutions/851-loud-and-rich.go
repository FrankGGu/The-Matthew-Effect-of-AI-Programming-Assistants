func loudAndRich(richer [][]int, quiet []int) []int {
    n := len(quiet)
    graph := make([][]int, n)
    indegree := make([]int, n)

    for _, pair := range richer {
        graph[pair[1]] = append(graph[pair[1]], pair[0])
        indegree[pair[0]]++
    }

    result := make([]int, n)
    for i := range result {
        result[i] = i
    }

    queue := []int{}
    for i := 0; i < n; i++ {
        if indegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    for len(queue) > 0 {
        curr := queue[0]
        queue = queue[1:]

        for _, neighbor := range graph[curr] {
            if quiet[result[curr]] < quiet[result[neighbor]] {
                result[neighbor] = result[curr]
            } else if quiet[result[curr]] == quiet[result[neighbor]] && result[curr] < result[neighbor] {
                result[neighbor] = result[curr]
            }
            indegree[neighbor]--
            if indegree[neighbor] == 0 {
                queue = append(queue, neighbor)
            }
        }
    }

    return result
}