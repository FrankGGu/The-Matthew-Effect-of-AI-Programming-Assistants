package main

func pathWithMaxScore(board [][]string) []int {
    maxScore := make([][]int, len(board))
    count := make([][]int, len(board))
    for i := range maxScore {
        maxScore[i] = make([]int, len(board[0]))
        count[i] = make([]int, len(board[0]))
    }

    maxScore[len(board)-1][len(board[0])-1] = 0
    count[len(board)-1][len(board[0])-1] = 1

    for i := len(board) - 1; i >= 0; i-- {
        for j := len(board[0]) - 1; j >= 0; j-- {
            if board[i][j] == "X" {
                continue
            }
            if i == len(board)-1 && j == len(board[0])-1 {
                continue
            }
            currentVal := 0
            if board[i][j] != "S" {
                currentVal = int(board[i][j][0] - '0')
            }
            maxScore[i][j] = -1
            for _, dir := range [][2]int{{0, 1}, {1, 0}, {1, 1}} {
                ni, nj := i+dir[0], j+dir[1]
                if ni < len(board) && nj < len(board[0]) && board[ni][nj] != "X" {
                    if maxScore[ni][nj] != -1 {
                        if maxScore[i][j] < maxScore[ni][nj]+currentVal {
                            maxScore[i][j] = maxScore[ni][nj] + currentVal
                            count[i][j] = count[ni][nj]
                        } else if maxScore[i][j] == maxScore[ni][nj]+currentVal {
                            count[i][j] += count[ni][nj]
                        }
                    }
                }
            }
        }
    }

    result := []int{maxScore[0][0], count[0][0]}
    return result
}