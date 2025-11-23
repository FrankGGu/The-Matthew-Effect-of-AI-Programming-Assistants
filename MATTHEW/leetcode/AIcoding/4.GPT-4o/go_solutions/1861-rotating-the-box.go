func rotateTheBox(box [][]byte) [][]byte {
    m, n := len(box), len(box[0])
    result := make([][]byte, n)
    for i := range result {
        result[i] = make([]byte, m)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            result[j][m-1-i] = box[i][j]
        }
    }

    for j := 0; j < n; j++ {
        k := m - 1
        for i := m - 1; i >= 0; i-- {
            if result[j][i] == '#' {
                result[j][i], result[j][k] = '.', result[j][i]
                k--
            } else if result[j][i] == '*' {
                k = i - 1
            }
        }
    }

    return result
}