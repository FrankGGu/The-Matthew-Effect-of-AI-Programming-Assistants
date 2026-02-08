package main

func buildMatrix(cols int, rows int, constraints [][]int) [][]int {
    graph := make(map[int][]int)
    inDegree := make(map[int]int)
    for _, c := range constraints {
        u, v := c[0], c[1]
        graph[u] = append(graph[u], v)
        inDegree[v]++
    }

    var topSort func(int) []int
    topSort = func(start int) []int {
        visited := make(map[int]bool)
        result := []int{}
        var dfs func(int)
        dfs = func(u int) {
            visited[u] = true
            for _, v := range graph[u] {
                if !visited[v] {
                    dfs(v)
                }
            }
            result = append(result, u)
        }
        dfs(start)
        return result
    }

    nodes := make(map[int]bool)
    for _, c := range constraints {
        nodes[c[0]] = true
        nodes[c[1]] = true
    }

    for i := 1; i <= cols; i++ {
        nodes[i] = true
    }

    for i := 1; i <= rows; i++ {
        nodes[i] = true
    }

    var order []int
    for node := range nodes {
        if inDegree[node] == 0 {
            order = append(order, node)
        }
    }

    for len(order) > 0 {
        u := order[0]
        order = order[1:]
        for _, v := range graph[u] {
            inDegree[v]--
            if inDegree[v] == 0 {
                order = append(order, v)
            }
        }
    }

    for _, v := range inDegree {
        if v > 0 {
            return [][]int{}
        }
    }

    var rowOrder []int
    for node := range nodes {
        if inDegree[node] == 0 {
            rowOrder = append(rowOrder, node)
        }
    }

    for len(rowOrder) > 0 {
        u := rowOrder[0]
        rowOrder = rowOrder[1:]
        for _, v := range graph[u] {
            inDegree[v]--
            if inDegree[v] == 0 {
                rowOrder = append(rowOrder, v)
            }
        }
    }

    matrix := make([][]int, rows)
    for i := range matrix {
        matrix[i] = make([]int, cols)
    }

    colMap := make(map[int]int)
    rowMap := make(map[int]int)

    for i, node := range topSort(1) {
        colMap[node] = i
    }

    for i, node := range topSort(1) {
        rowMap[node] = i
    }

    for _, c := range constraints {
        u, v := c[0], c[1]
        if colMap[u] < colMap[v] && rowMap[u] < rowMap[v] {
            continue
        }
        return [][]int{}
    }

    for i := 1; i <= cols; i++ {
        for j := 1; j <= rows; j++ {
            if colMap[i] < colMap[j] && rowMap[i] < rowMap[j] {
                matrix[rowMap[j]][colMap[i]] = 1
            }
        }
    }

    return matrix
}