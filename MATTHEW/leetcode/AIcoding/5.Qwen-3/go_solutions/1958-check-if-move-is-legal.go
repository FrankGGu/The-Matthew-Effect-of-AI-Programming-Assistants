package main

func isLegalMove(board []string, move string) bool {
    if len(move) != 4 {
        return false
    }
    from := move[:2]
    to := move[2:]
    fromRow, fromCol := int(from[1]-'1'), int(from[0]-'a')
    toRow, toCol := int(to[1]-'1'), int(to[0]-'a')
    if fromRow < 0 || fromRow >= 8 || fromCol < 0 || fromCol >= 8 || toRow < 0 || toRow >= 8 || toCol < 0 || toCol >= 8 {
        return false
    }
    piece := board[fromRow][fromCol]
    if piece == ' ' {
        return false
    }
    if piece == 'P' && toRow == fromRow+1 && toCol == fromCol && board[toRow][toCol] == ' ' {
        return true
    }
    if piece == 'P' && toRow == fromRow+2 && toCol == fromCol && fromRow == 1 && board[toRow][toCol] == ' ' && board[fromRow+1][fromCol] == ' ' {
        return true
    }
    if piece == 'P' && toRow == fromRow+1 && (toCol == fromCol+1 || toCol == fromCol-1) && board[toRow][toCol] != ' ' && board[toRow][toCol] >= 'a' && board[toRow][toCol] <= 'z' {
        return true
    }
    if piece == 'p' && toRow == fromRow-1 && toCol == fromCol && board[toRow][toCol] == ' ' {
        return true
    }
    if piece == 'p' && toRow == fromRow-2 && toCol == fromCol && fromRow == 6 && board[toRow][toCol] == ' ' && board[fromRow-1][fromCol] == ' ' {
        return true
    }
    if piece == 'p' && toRow == fromRow-1 && (toCol == fromCol+1 || toCol == fromCol-1) && board[toRow][toCol] != ' ' && board[toRow][toCol] >= 'A' && board[toRow][toCol] <= 'Z' {
        return true
    }
    if piece == 'R' {
        if fromRow == toRow {
            step := 1
            if fromCol > toCol {
                step = -1
            }
            for i := fromCol + step; i != toCol; i += step {
                if board[fromRow][i] != ' ' {
                    return false
                }
            }
            return board[toRow][toCol] == ' ' || (board[toRow][toCol] >= 'a' && board[toRow][toCol] <= 'z')
        }
        if fromCol == toCol {
            step := 1
            if fromRow > toRow {
                step = -1
            }
            for i := fromRow + step; i != toRow; i += step {
                if board[i][fromCol] != ' ' {
                    return false
                }
            }
            return board[toRow][toCol] == ' ' || (board[toRow][toCol] >= 'a' && board[toRow][toCol] <= 'z')
        }
        return false
    }
    if piece == 'r' {
        if fromRow == toRow {
            step := 1
            if fromCol > toCol {
                step = -1
            }
            for i := fromCol + step; i != toCol; i += step {
                if board[fromRow][i] != ' ' {
                    return false
                }
            }
            return board[toRow][toCol] == ' ' || (board[toRow][toCol] >= 'A' && board[toRow][toCol] <= 'Z')
        }
        if fromCol == toCol {
            step := 1
            if fromRow > toRow {
                step = -1
            }
            for i := fromRow + step; i != toRow; i += step {
                if board[i][fromCol] != ' ' {
                    return false
                }
            }
            return board[toRow][toCol] == ' ' || (board[toRow][toCol] >= 'A' && board[toRow][toCol] <= 'Z')
        }
        return false
    }
    if piece == 'N' {
        return (abs(fromRow-toRow) == 2 && abs(fromCol-toCol) == 1) || (abs(fromRow-toRow) == 1 && abs(fromCol-toCol) == 2) && (board[toRow][toCol] == ' ' || (board[toRow][toCol] >= 'a' && board[toRow][toCol] <= 'z'))
    }
    if piece == 'n' {
        return (abs(fromRow-toRow) == 2 && abs(fromCol-toCol) == 1) || (abs(fromRow-toRow) == 1 && abs(fromCol-toCol) == 2) && (board[toRow][toCol] == ' ' || (board[toRow][toCol] >= 'A' && board[toRow][toCol] <= 'Z'))
    }
    if piece == 'B' {
        if abs(fromRow-toRow) != abs(fromCol-toCol) {
            return false
        }
        stepRow := 1
        if fromRow > toRow {
            stepRow = -1
        }
        stepCol := 1
        if fromCol > toCol {
            stepCol = -1
        }
        for i := 1; i < abs(fromRow-toRow); i++ {
            if board[fromRow+i*stepRow][fromCol+i*stepCol] != ' ' {
                return false
            }
        }
        return board[toRow][toCol] == ' ' || (board[toRow][toCol] >= 'a' && board[toRow][toCol] <= 'z')
    }
    if piece == 'b' {
        if abs(fromRow-toRow) != abs(fromCol-toCol) {
            return false
        }
        stepRow := 1
        if fromRow > toRow {
            stepRow = -1
        }
        stepCol := 1
        if fromCol > toCol {
            stepCol = -1
        }
        for i := 1; i < abs(fromRow-toRow); i++ {
            if board[fromRow+i*stepRow][fromCol+i*stepCol] != ' ' {
                return false
            }
        }
        return board[toRow][toCol] == ' ' || (board[toRow][toCol] >= 'A' && board[toRow][toCol] <= 'Z')
    }
    if piece == 'Q' {
        if fromRow == toRow {
            step := 1
            if fromCol > toCol {
                step = -1
            }
            for i := fromCol + step; i != toCol; i += step {
                if board[fromRow][i] != ' ' {
                    return false
                }
            }
            return board[toRow][toCol] == ' ' || (board[toRow][toCol] >= 'a' && board[toRow][toCol] <= 'z')
        }
        if fromCol == toCol {
            step := 1
            if fromRow > toRow {
                step = -1
            }
            for i := fromRow + step; i != toRow; i += step {
                if board[i][fromCol] != ' ' {
                    return false
                }
            }
            return board[toRow][toCol] == ' ' || (board[toRow][toCol] >= 'a' && board[toRow][toCol] <= 'z')
        }
        if abs(fromRow-toRow) == abs(fromCol-toCol) {
            stepRow := 1
            if fromRow > toRow {
                stepRow = -1
            }
            stepCol := 1
            if fromCol > toCol {
                stepCol = -1
            }
            for i := 1; i < abs(fromRow-toRow); i++ {
                if board[fromRow+i*stepRow][fromCol+i*stepCol] != ' ' {
                    return false
                }
            }
            return board[toRow][toCol] == ' ' || (board[toRow][toCol] >= 'a' && board[toRow][toCol] <= 'z')
        }
        return false
    }
    if piece == 'q' {
        if fromRow == toRow {
            step := 1
            if fromCol > toCol {
                step = -1
            }
            for i := fromCol + step; i != toCol; i += step {
                if board[fromRow][i] != ' ' {
                    return false
                }
            }
            return board[toRow][toCol] == ' ' || (board[toRow][toCol] >= 'A' && board[toRow][toCol] <= 'Z')
        }
        if fromCol == toCol {
            step := 1
            if fromRow > toRow {
                step = -1