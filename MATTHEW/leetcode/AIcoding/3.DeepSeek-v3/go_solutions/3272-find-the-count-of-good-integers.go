func countGoodIntegers(start int64, end int64, k int64) int64 {
    return calculate(end, k) - calculate(start-1, k)
}

func calculate(n int64, k int64) int64 {
    s := strconv.FormatInt(n, 10)
    m := len(s)
    memo := make([][]int64, m)
    for i := range memo {
        memo[i] = make([]int64, 1<<10)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }
    var dfs func(int, int, bool, bool) int64
    dfs = func(pos int, mask int, tight bool, isNum bool) int64 {
        if pos == m {
            if isNum && mask == 1<<k {
                return 1
            }
            return 0
        }
        if !tight && isNum && memo[pos][mask] != -1 {
            return memo[pos][mask]
        }
        res := int64(0)
        if !isNum {
            res += dfs(pos+1, mask, false, false)
        }
        up := 9
        if tight {
            up = int(s[pos] - '0')
        }
        d := 0
        if !isNum {
            d = 1
        }
        for ; d <= up; d++ {
            newMask := mask
            if isNum || d > 0 {
                newMask |= 1 << d
            }
            res += dfs(pos+1, newMask, tight && d == up, isNum || d > 0)
        }
        if !tight && isNum {
            memo[pos][mask] = res
        }
        return res
    }
    return dfs(0, 0, true, false)
}