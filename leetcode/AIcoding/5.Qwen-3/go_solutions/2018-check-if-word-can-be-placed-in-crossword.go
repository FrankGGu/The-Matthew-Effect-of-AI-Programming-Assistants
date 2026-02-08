package main

func placeWordInCrossword(board [][]byte, word string) bool {
    rows, cols := len(board), len(board[0])
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            for _, dir := range directions {
                x, y := i, j
                match := true
                for k := 0; k < len(word); k++ {
                    if x < 0 || x >= rows || y < 0 || y >= cols {
                        match = false
                        break
                    }
                    if board[x][y] != ' ' && board[x][y] != word[k] {
                        match = false
                        break
                    }
                    x += dir[0]
                    y += dir[1]
                }
                if match {
                    return true
                }
            }
        }
    }
    return false
}