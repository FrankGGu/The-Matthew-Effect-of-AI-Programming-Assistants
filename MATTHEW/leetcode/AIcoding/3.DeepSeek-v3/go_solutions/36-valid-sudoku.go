func isValidSudoku(board [][]byte) bool {
    rows := make([]map[byte]bool, 9)
    cols := make([]map[byte]bool, 9)
    boxes := make([]map[byte]bool, 9)

    for i := 0; i < 9; i++ {
        rows[i] = make(map[byte]bool)
        cols[i] = make(map[byte]bool)
        boxes[i] = make(map[byte]bool)
    }

    for i := 0; i < 9; i++ {
        for j := 0; j < 9; j++ {
            val := board[i][j]
            if val == '.' {
                continue
            }

            if rows[i][val] {
                return false
            }
            rows[i][val] = true

            if cols[j][val] {
                return false
            }
            cols[j][val] = true

            boxIdx := (i / 3) * 3 + j / 3
            if boxes[boxIdx][val] {
                return false
            }
            boxes[boxIdx][val] = true
        }
    }

    return true
}