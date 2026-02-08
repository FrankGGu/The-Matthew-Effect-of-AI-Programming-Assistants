func decodeCiphertext(encodedText string, rows int) string {
    if rows == 1 {
        return encodedText
    }
    n := len(encodedText)
    cols := n / rows
    res := []byte{}
    for i := 0; i < cols; i++ {
        for j := 0; j < rows && i+j < cols; j++ {
            idx := j*cols + i + j
            if idx < n {
                res = append(res, encodedText[idx])
            }
        }
    }
    for len(res) > 0 && res[len(res)-1] == ' ' {
        res = res[:len(res)-1]
    }
    return string(res)
}