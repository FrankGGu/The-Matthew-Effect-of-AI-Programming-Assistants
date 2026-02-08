func findGoodStrings(n int, s1 string, s2 string, evil string) int {
    mod := int(1e9 + 7)
    m := len(evil)
    dp := make([][][]int, n)
    for i := range dp {
        dp[i] = make([][]int, m)
        for j := range dp[i] {
            dp[i][j] = make([]int, 2)
            for k := range dp[i][j] {
                dp[i][j][k] = -1
            }
        }
    }

    memo := make([][]int, m)
    for i := range memo {
        memo[i] = make([]int, 26)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    var kmp func(int, byte) int
    kmp = func(state int, c byte) int {
        if memo[state][c-'a'] != -1 {
            return memo[state][c-'a']
        }
        nextState := state
        for nextState > 0 && evil[nextState] != c {
            nextState = memo[nextState][c-'a']
        }
        if evil[nextState] == c {
            nextState++
        }
        memo[state][c-'a'] = nextState
        return nextState
    }

    var dfs func(int, int, bool) int
    dfs = func(pos, state int, isLimit bool) int {
        if state == m {
            return 0
        }
        if pos == n {
            return 1
        }
        if !isLimit && dp[pos][state][0] != -1 {
            return dp[pos][state][0]
        }
        res := 0
        limit := byte('z')
        if isLimit {
            limit = s2[pos]
        }
        for c := byte('a'); c <= limit; c++ {
            nextState := kmp(state, c)
            nextIsLimit := isLimit && c == limit
            res = (res + dfs(pos+1, nextState, nextIsLimit)) % mod
        }
        if !isLimit {
            dp[pos][state][0] = res
        }
        return res
    }

    var dfs2 func(int, int, bool) int
    dfs2 = func(pos, state int, isLimit bool) int {
        if state == m {
            return 0
        }
        if pos == n {
            return 1
        }
        if !isLimit && dp[pos][state][1] != -1 {
            return dp[pos][state][1]
        }
        res := 0
        limit := byte('z')
        if isLimit {
            limit = s1[pos] - 1
        }
        for c := byte('a'); c <= limit; c++ {
            nextState := kmp(state, c)
            nextIsLimit := isLimit && c == limit
            res = (res + dfs2(pos+1, nextState, nextIsLimit)) % mod
        }
        if !isLimit {
            dp[pos][state][1] = res
        }
        return res
    }

    total := (dfs(0, 0, true) - dfs2(0, 0, true) + mod) % mod

    if !strings.Contains(s1, evil) {
        total = (total + 1) % mod
    }

    return total
}