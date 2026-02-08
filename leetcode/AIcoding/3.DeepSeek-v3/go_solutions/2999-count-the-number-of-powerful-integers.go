func numberOfPowerfulInt(start int64, finish int64, limit int, s string) int64 {
    low := strconv.FormatInt(start, 10)
    high := strconv.FormatInt(finish, 10)
    n := len(s)
    memo := make([][]int64, 20)
    for i := range memo {
        memo[i] = make([]int64, 2)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    var dfs func(pos int, tight bool) int64
    dfs = func(pos int, tight bool) int64 {
        if pos == len(high) - n {
            if tight {
                suffix := high[pos:]
                if suffix < s {
                    return 0
                }
            }
            return 1
        }
        if memo[pos][boolToInt(tight)] != -1 {
            return memo[pos][boolToInt(tight)]
        }
        maxDigit := 9
        if tight {
            maxDigit = int(high[pos] - '0')
        }
        maxDigit = min(maxDigit, limit)
        res := int64(0)
        for d := 0; d <= maxDigit; d++ {
            newTight := tight && (d == maxDigit)
            res += dfs(pos+1, newTight)
        }
        memo[pos][boolToInt(tight)] = res
        return res
    }

    upper := dfs(0, true)

    memo = make([][]int64, 20)
    for i := range memo {
        memo[i] = make([]int64, 2)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    high = strconv.FormatInt(start-1, 10)
    if len(high) < n {
        return upper
    }
    lower := dfs(0, true)
    return upper - lower
}

func boolToInt(b bool) int {
    if b {
        return 1
    }
    return 0
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}