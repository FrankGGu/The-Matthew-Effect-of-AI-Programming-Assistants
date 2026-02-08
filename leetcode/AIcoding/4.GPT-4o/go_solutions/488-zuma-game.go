func findMinStep(board string, hand string) int {
    handCount := [5]int{}
    for _, c := range hand {
        handCount[c-'A']++
    }

    minSteps := dfs(board, handCount)
    if minSteps == math.MaxInt32 {
        return -1
    }
    return minSteps
}

func dfs(board string, handCount [5]int) int {
    board = removeConsecutive(board)
    if board == "" {
        return 0
    }
    if len(board)+sum(handCount) < len(board) {
        return math.MaxInt32
    }

    minSteps := math.MaxInt32
    for i := 0; i < len(board); i++ {
        j := i
        for j < len(board) && board[j] == board[i] {
            j++
        }
        need := 3 - (j - i)
        if need <= 0 {
            continue
        }
        if handCount[board[i]-'A'] >= need {
            handCount[board[i]-'A'] -= need
            nextBoard := board[:i] + board[j:]
            steps := dfs(nextBoard, handCount)
            if steps != math.MaxInt32 {
                minSteps = min(minSteps, steps+need)
            }
            handCount[board[i]-'A'] += need
        }
    }
    return minSteps
}

func removeConsecutive(board string) string {
    n := len(board)
    if n == 0 {
        return ""
    }
    result := []byte{}
    count := 0
    for i := 0; i < n; i++ {
        if len(result) > 0 && result[len(result)-1] == board[i] {
            count++
        } else {
            if count >= 2 {
                result = result[:len(result)-count]
            }
            result = append(result, board[i])
            count = 1
        }
    }
    if count >= 2 {
        result = result[:len(result)-count]
    }
    return string(result)
}

func sum(handCount [5]int) int {
    total := 0
    for _, count := range handCount {
        total += count
    }
    return total
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}