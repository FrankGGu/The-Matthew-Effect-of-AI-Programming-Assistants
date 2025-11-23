package main

func canMouseWin(board []string, catJump int, mouseJump int) bool {
    m, n := len(board), len(board[0])
    var mouse, cat [2]int
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if board[i][j] == 'M' {
                mouse = [2]int{i, j}
            } else if board[i][j] == 'C' {
                cat = [2]int{i, j}
            }
        }
    }

    memo := map[[3]int]bool{}
    var dfs func(mouse, cat, turn int) bool
    dfs = func(mouse, cat, turn int) bool {
        if turn >= 2*m*n {
            return false
        }
        key := [3]int{mouse[0], mouse[1], cat[0], cat[1], turn}
        if val, ok := memo[key]; ok {
            return val
        }

        isMouseTurn := turn%2 == 0
        if isMouseTurn {
            for _, dir := range [][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}} {
                for step := 1; step <= mouseJump; step++ {
                    x, y := mouse[0]+dir[0]*step, mouse[1]+dir[1]*step
                    if x < 0 || x >= m || y < 0 || y >= n || board[x][y] == 'D' {
                        break
                    }
                    if board[x][y] == 'F' {
                        memo[key] = true
                        return true
                    }
                    if dfs([2]int{x, y}, cat, turn+1) {
                        memo[key] = true
                        return true
                    }
                }
            }
            memo[key] = false
            return false
        } else {
            for _, dir := range [][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}} {
                for step := 1; step <= catJump; step++ {
                    x, y := cat[0]+dir[0]*step, cat[1]+dir[1]*step
                    if x < 0 || x >= m || y < 0 || y >= n || board[x][y] == 'D' {
                        break
                    }
                    if board[x][y] == 'F' {
                        memo[key] = false
                        return false
                    }
                    if !dfs(mouse, [2]int{x, y}, turn+1) {
                        memo[key] = false
                        return false
                    }
                }
            }
            memo[key] = true
            return true
        }
    }

    return dfs(mouse, cat, 0)
}