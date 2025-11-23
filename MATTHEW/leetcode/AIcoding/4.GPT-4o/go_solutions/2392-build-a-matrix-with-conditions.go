func constructMatrix(m int, n int, rowConditions [][]int, colConditions [][]int) [][]int {
    rowGraph := make([][]int, m)
    colGraph := make([][]int, n)
    rowIndegree := make([]int, m)
    colIndegree := make([]int, n)

    for _, condition := range rowConditions {
        a, b := condition[0]-1, condition[1]-1
        rowGraph[a] = append(rowGraph[a], b)
        rowIndegree[b]++
    }

    for _, condition := range colConditions {
        a, b := condition[0]-1, condition[1]-1
        colGraph[a] = append(colGraph[a], b)
        colIndegree[b]++
    }

    rowOrder := topologicalSort(rowGraph, rowIndegree, m)
    colOrder := topologicalSort(colGraph, colIndegree, n)

    if len(rowOrder) != m || len(colOrder) != n {
        return [][]int{}
    }

    matrix := make([][]int, m)
    for i := range matrix {
        matrix[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            matrix[i][j] = rowOrder[i]*n + colOrder[j] + 1
        }
    }

    return matrix
}

func topologicalSort(graph [][]int, indegree []int, size int) []int {
    order := []int{}
    queue := []int{}

    for i := 0; i < size; i++ {
        if indegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        order = append(order, node)

        for _, neighbor := range graph[node] {
            indegree[neighbor]--
            if indegree[neighbor] == 0 {
                queue = append(queue, neighbor)
            }
        }
    }

    return order
}