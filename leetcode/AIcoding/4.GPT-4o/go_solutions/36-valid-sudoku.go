func isValidSudoku(board [][]byte) bool {
    rows := [9]map[byte]bool{}
    cols := [9]map[byte]bool{}
    boxes := [9]map[byte]bool{}

    for i := 0; i < 9; i++ {
        rows[i] = make(map[byte]bool)
        cols[i] = make(map[byte]bool)
        boxes[i] = make(map[byte]bool)
    }

    for r := 0; r < 9; r++ {
        for c := 0; c < 9; c++ {
            if board[r][c] != '.' {
                num := board[r][c]
                boxIndex := (r/3)*3 + c/3

                if rows[r][num] || cols[c][num] || boxes[boxIndex][num] {
                    return false
                }

                rows[r][num] = true
                cols[c][num] = true
                boxes[boxIndex][num] = true
            }
        }
    }

    return true
}