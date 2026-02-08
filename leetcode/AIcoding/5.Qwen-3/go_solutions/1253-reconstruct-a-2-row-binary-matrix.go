package main

func findMatrix(rowConditions [][]int, colConditions [][]int) [][]int {
    n := len(rowConditions)
    m := len(colConditions)

    rowOrder := make([]int, n)
    colOrder := make([]int, m)

    inDegreeRow := make([]int, n)
    inDegreeCol := make([]int, m)

    graphRow := make([][]int, n)
    graphCol := make([][]int, m)

    for _, cond := range rowConditions {
        u, v := cond[0], cond[1]
        graphRow[u] = append(graphRow[u], v)
        inDegreeRow[v]++
    }

    for _, cond := range colConditions {
        u, v := cond[0], cond[1]
        graphCol[u] = append(graphCol[u], v)
        inDegreeCol[v]++
    }

    q := make([]int, 0)
    for i := 0; i < n; i++ {
        if inDegreeRow[i] == 0 {
            q = append(q, i)
        }
    }

    idx := 0
    for len(q) > 0 {
        u := q[0]
        q = q[1:]
        rowOrder[idx] = u
        idx++
        for _, v := range graphRow[u] {
            inDegreeRow[v]--
            if inDegreeRow[v] == 0 {
                q = append(q, v)
            }
        }
    }

    if idx != n {
        return [][]int{}
    }

    q = make([]int, 0)
    for i := 0; i < m; i++ {
        if inDegreeCol[i] == 0 {
            q = append(q, i)
        }
    }

    idx = 0
    for len(q) > 0 {
        u := q[0]
        q = q[1:]
        colOrder[idx] = u
        idx++
        for _, v := range graphCol[u] {
            inDegreeCol[v]--
            if inDegreeCol[v] == 0 {
                q = append(q, v)
            }
        }
    }

    if idx != m {
        return [][]int{}
    }

    matrix := make([][]int, 2)
    for i := 0; i < 2; i++ {
        matrix[i] = make([]int, m)
    }

    for i := 0; i < n; i++ {
        row := rowOrder[i]
        for j := 0; j < m; j++ {
            if colOrder[j] == row {
                matrix[0][j] = 1
                break
            }
        }
    }

    for i := 0; i < m; i++ {
        col := colOrder[i]
        for j := 0; j < n; j++ {
            if rowOrder[j] == col {
                matrix[1][i] = 1
                break
            }
        }
    }

    return matrix
}