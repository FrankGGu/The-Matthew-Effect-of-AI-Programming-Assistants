func checkIfPrerequisite(numCourses int, prerequisites [][]int, queries [][]int) []bool {
    adj := make([][]bool, numCourses)
    for i := range adj {
        adj[i] = make([]bool, numCourses)
    }

    for _, p := range prerequisites {
        adj[p[0]][p[1]] = true
    }

    for k := 0; k < numCourses; k++ {
        for i := 0; i < numCourses; i++ {
            for j := 0; j < numCourses; j++ {
                if adj[i][k] && adj[k][j] {
                    adj[i][j] = true
                }
            }
        }
    }

    res := make([]bool, len(queries))
    for i, q := range queries {
        res[i] = adj[q[0]][q[1]]
    }
    return res
}