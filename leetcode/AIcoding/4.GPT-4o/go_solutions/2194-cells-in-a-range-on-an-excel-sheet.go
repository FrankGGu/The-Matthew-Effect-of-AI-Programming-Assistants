func cellsInRange(s string) []string {
    result := []string{}
    startCol := s[0]
    endCol := s[3]
    startRow := s[1] - '0'
    endRow := s[4] - '0'

    for col := startCol; col <= endCol; col++ {
        for row := startRow; row <= endRow; row++ {
            result = append(result, fmt.Sprintf("%c%d", col, row))
        }
    }

    return result
}