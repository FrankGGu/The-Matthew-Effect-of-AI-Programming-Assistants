package main

func decodeCiphertext(encodedString string, rows int) string {
    if rows == 0 || len(encodedString) == 0 {
        return ""
    }
    n := len(encodedString)
    cols := (n + rows - 1) / rows
    result := make([]byte, 0, n)
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            index := i + j*rows
            if index < n {
                result = append(result, encodedString[index])
            }
        }
    }
    return string(result)
}