func findMinStep(board string, hand string) int {
    count := make(map[byte]int)
    for i := 0; i < len(hand); i++ {
        count[hand[i]]++
    }
    return dfs(board, count)
}

func dfs(board string, count map[byte]int) int {
    board = removeConsecutive(board)
    if board == "" {
        return 0
    }
    ans := math.MaxInt32
    for i := 0; i < len(board); i++ {
        for j := 1; j <= count[board[i]]; j++ {
            newCount := make(map[byte]int)
            for k, v := range count {
                newCount[k] = v
            }
            newCount[board[i]] -= j
            if newCount[board[i]] < 0 {
                continue
            }
            newBoard := insertBalls(board, i, j)
            temp := dfs(newBoard, newCount)
            if temp != -1 {
                ans = min(ans, temp+j)
            }
        }
    }
    if ans == math.MaxInt32 {
        return -1
    }
    return ans
}

func removeConsecutive(board string) string {
    var sb strings.Builder
    for i := 0; i < len(board); i++ {
        if sb.Len() == 0 || sb.String()[sb.Len()-1] != board[i] {
            sb.WriteByte(board[i])
        } else {
            for sb.Len() > 0 && sb.String()[sb.Len()-1] == board[i] {
                sb.Truncate(sb.Len() - 1)
            }
        }
    }
    return sb.String()
}

func insertBalls(board string, index int, count int) string {
    return board[:index] + strings.Repeat(string(board[index]), count) + board[index:]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}