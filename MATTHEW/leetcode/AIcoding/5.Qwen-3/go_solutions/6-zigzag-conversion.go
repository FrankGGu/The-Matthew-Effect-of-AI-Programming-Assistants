package main

func convert(s string, numRows int) string {
    if numRows == 1 || numRows >= len(s) {
        return s
    }
    rows := make([]string, numRows)
    currentRow := 0
    goingDown := false
    for _, char := range s {
        rows[currentRow] += string(char)
        if currentRow == 0 || currentRow == numRows-1 {
            goingDown = !goingDown
        }
        if goingDown {
            currentRow++
        } else {
            currentRow--
        }
    }
    result := ""
    for _, row := range rows {
        result += row
    }
    return result
}