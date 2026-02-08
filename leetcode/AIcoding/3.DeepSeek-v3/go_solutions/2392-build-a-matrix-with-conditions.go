func buildMatrix(k int, rowConditions [][]int, colConditions [][]int) [][]int {
    rowOrder := topoSort(k, rowConditions)
    colOrder := topoSort(k, colConditions)
    if rowOrder == nil || colOrder == nil {
        return [][]int{}
    }

    pos := make([][]int, k+1)
    for i := 1; i <= k; i++ {
        pos[i] = make([]int, 2)
    }

    for i := 0; i < k; i++ {
        pos[rowOrder[i]][0] = i
        pos[colOrder[i]][1] = i
    }

    matrix := make([][]int, k)
    for i := 0; i < k; i++ {
        matrix[i] = make([]int, k)
    }

    for num := 1; num <= k; num++ {
        x, y := pos[num][0], pos[num][1]
        matrix[x][y] = num
    }

    return matrix
}

func topoSort(k int, conditions [][]int) []int {
    graph := make([][]int, k+1)
    inDegree := make([]int, k+1)
    for _, cond := range conditions {
        a, b := cond[0], cond[1]
        graph[a] = append(graph[a], b)
        inDegree[b]++
    }

    queue := []int{}
    for i := 1; i <= k; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    order := []int{}
    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        order = append(order, u)
        for _, v := range graph[u] {
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    if len(order) != k {
        return nil
    }
    return order
}