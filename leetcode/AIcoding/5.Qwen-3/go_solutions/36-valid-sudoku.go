package main

func isValidSudoku(board []byte) bool {
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
            num := board[i*9+j]
            if num == '.' {
                continue
            }
            if rows[i][num] {
                return false
            }
            rows[i][num] = true

            if cols[j][num] {
                return false
            }
            cols[j][num] = true

            boxIndex := (i/3)*3 + j/3
            if boxes[boxIndex][num] {
                return false
            }
            boxes[boxIndex][num] = true
        }
    }

    return true
}