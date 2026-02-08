func rotateTheBox(box [][]byte) [][]byte {
    m, n := len(box), len(box[0])
    for i := 0; i < m; i++ {
        pos := n - 1
        for j := n - 1; j >= 0; j-- {
            if box[i][j] == '*' {
                pos = j - 1
            } else if box[i][j] == '#' {
                box[i][j] = '.'
                box[i][pos] = '#'
                pos--
            }
        }
    }

    rotated := make([][]byte, n)
    for i := 0; i < n; i++ {
        rotated[i] = make([]byte, m)
    }
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            rotated[j][m-1-i] = box[i][j]
        }
    }
    return rotated
}