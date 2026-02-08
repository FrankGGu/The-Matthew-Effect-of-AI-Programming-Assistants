func decodeCiphertext(encodedText string, rows int) string {
    if rows == 0 {
        return ""
    }

    n := len(encodedText)
    cols := n / rows
    result := []rune{}

    for col := 0; col < cols; col++ {
        for row := 0; row < rows; row++ {
            idx := row + col
            if idx < cols {
                char := encodedText[row*cols+idx]
                if char != ' ' {
                    result = append(result, rune(char))
                }
            }
        }
    }

    return strings.TrimRight(string(result), " ")
}