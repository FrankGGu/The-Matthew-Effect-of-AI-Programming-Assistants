func countSpecialNumbers(n int) int {
    s := strconv.Itoa(n)
    m := len(s)
    memo := make([][1 << 10]int, m)
    for i := range memo {
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }
    var dfs func(int, int, bool, bool) int
    dfs = func(pos, mask int, isLimit, isNum bool) (res int) {
        if pos == m {
            if isNum {
                return 1
            }
            return 0
        }
        if !isLimit && isNum && memo[pos][mask] != -1 {
            return memo[pos][mask]
        }
        if !isNum {
            res += dfs(pos+1, mask, false, false)
        }
        d := 0
        if !isNum {
            d = 1
        }
        up := 9
        if isLimit {
            up = int(s[pos] - '0')
        }
        for ; d <= up; d++ {
            if mask>>d&1 == 0 {
                res += dfs(pos+1, mask|1<<d, isLimit && d == up, true)
            }
        }
        if !isLimit && isNum {
            memo[pos][mask] = res
        }
        return
    }
    return dfs(0, 0, true, false)
}