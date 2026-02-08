func buildMatrix(k int, rowConditions [][]int, colConditions [][]int) [][]int {
    rowOrder := topologicalSort(k, rowConditions)
    colOrder := topologicalSort(k, colConditions)

    if len(rowOrder) != k || len(colOrder) != k {
        return [][]int{}
    }

    rowMap := make(map[int]int)
    for i, val := range rowOrder {
        rowMap[val] = i
    }

    colMap := make(map[int]int)
    for i, val := range colOrder {
        colMap[val] = i
    }

    matrix := make([][]int, k)
    for i := range matrix {
        matrix[i] = make([]int, k)
    }

    for i := 1; i <= k; i++ {
        row := rowMap[i]
        col := colMap[i]
        matrix[row][col] = i
    }

    return matrix
}

func topologicalSort(k int, conditions [][]int) []int {
    inDegree := make([]int, k+1)
    graph := make(map[int][]int)

    for _, condition := range conditions {
        inDegree[condition[1]]++
        graph[condition[0]] = append(graph[condition[0]], condition[1])
    }

    queue := []int{}
    for i := 1; i <= k; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    result := []int{}
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        result = append(result, node)

        for _, neighbor := range graph[node] {
            inDegree[neighbor]--
            if inDegree[neighbor] == 0 {
                queue = append(queue, neighbor)
            }
        }
    }

    if len(result) != k {
        return []int{}
    }

    return result
}