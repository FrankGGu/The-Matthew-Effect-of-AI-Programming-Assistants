package main

func rotateTheBox(box [][]byte) [][]byte {
    m := len(box)
    n := len(box[0])
    result := make([][]byte, n)
    for i := range result {
        result[i] = make([]byte, m)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            result[j][m-1-i] = box[i][j]
        }
    }
    return result
}