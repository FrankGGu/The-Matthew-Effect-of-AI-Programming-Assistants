func slidingPuzzle(board [][]int) int {
    target := "123450"
    moves := [][]int{{1, 3}, {0, 2, 4}, {1, 5}, {0, 4}, {1, 3, 5}, {2, 4}}

    var sb strings.Builder
    for i := 0; i < 2; i++ {
        for j := 0; j < 3; j++ {
            sb.WriteString(strconv.Itoa(board[i][j]))
        }
    }
    start := sb.String()

    visited := make(map[string]bool)
    queue := []string{start}
    visited[start] = true
    steps := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[i]
            if current == target {
                return steps
            }
            zeroIndex := strings.Index(current, "0")
            for _, move := range moves[zeroIndex] {
                newState := []byte(current)
                newState[zeroIndex], newState[move] = newState[move], newState[zeroIndex]
                newStateStr := string(newState)
                if !visited[newStateStr] {
                    visited[newStateStr] = true
                    queue = append(queue, newStateStr)
                }
            }
        }
        queue = queue[size:]
        steps++
    }

    return -1
}