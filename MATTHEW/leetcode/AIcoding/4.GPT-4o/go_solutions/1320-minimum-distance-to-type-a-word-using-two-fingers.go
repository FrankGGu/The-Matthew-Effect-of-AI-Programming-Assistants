func minimumDistance(word string) int {
    dp := make([][]int, 26)
    for i := range dp {
        dp[i] = make([]int, 26)
    }

    for i := 0; i < 26; i++ {
        for j := 0; j < 26; j++ {
            dp[i][j] = abs(i/6-j/6) + abs(i%6-j%6)
        }
    }

    n := len(word)
    if n == 0 {
        return 0
    }

    memo := make(map[[3]int]int)
    var dfs func(int, int, int) int
    dfs = func(i, pos1, pos2 int) int {
        if i == n {
            return 0
        }
        key := [3]int{i, pos1, pos2}
        if val, ok := memo[key]; ok {
            return val
        }
        nextPos := int(word[i] - 'A')
        res := math.MaxInt32
        if pos1 == -1 {
            res = dfs(i+1, nextPos, pos2) + 0
        } else {
            res = min(res, dfs(i+1, nextPos, pos2)+dp[pos1][nextPos])
        }
        if pos2 == -1 {
            res = min(res, dfs(i+1, pos1, nextPos)+0)
        } else {
            res = min(res, dfs(i+1, pos1, nextPos)+dp[pos2][nextPos])
        }
        memo[key] = res
        return res
    }

    return dfs(0, -1, -1)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}