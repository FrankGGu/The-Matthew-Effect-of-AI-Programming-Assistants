func findMinStep(board string, hand string) int {
    handCount := make([]int, 26)
    for _, c := range hand {
        handCount[c-'A']++
    }
    res := dfs(board, handCount)
    if res == math.MaxInt32 {
        return -1
    }
    return res
}

func dfs(board string, handCount []int) int {
    if len(board) == 0 {
        return 0
    }
    res := math.MaxInt32
    i := 0
    for i < len(board) {
        j := i
        for j < len(board) && board[j] == board[i] {
            j++
        }
        color := board[i] - 'A'
        need := 3 - (j - i)
        if handCount[color] >= need {
            handCount[color] -= need
            newBoard := updateBoard(board[:i] + board[j:])
            temp := dfs(newBoard, handCount)
            if temp != math.MaxInt32 {
                res = min(res, temp + need)
            }
            handCount[color] += need
        }
        i = j
    }
    return res
}

func updateBoard(board string) string {
    i := 0
    for i < len(board) {
        j := i
        for j < len(board) && board[j] == board[i] {
            j++
        }
        if j - i >= 3 {
            return updateBoard(board[:i] + board[j:])
        }
        i = j
    }
    return board
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}