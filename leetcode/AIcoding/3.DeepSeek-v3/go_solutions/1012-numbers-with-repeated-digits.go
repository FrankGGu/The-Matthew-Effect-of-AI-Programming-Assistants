func numDupDigitsAtMostN(N int) int {
    s := strconv.Itoa(N)
    n := len(s)
    memo := make([][1 << 10]int, n)
    for i := range memo {
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    var dfs func(int, int, bool, bool) int
    dfs = func(pos int, mask int, tight bool, hasDup bool) int {
        if pos == n {
            if hasDup {
                return 1
            }
            return 0
        }
        if !tight && !hasDup && memo[pos][mask] != -1 {
            return memo[pos][mask]
        }
        limit := 9
        if tight {
            limit = int(s[pos] - '0')
        }
        res := 0
        for d := 0; d <= limit; d++ {
            newTight := tight && (d == limit)
            newHasDup := hasDup
            newMask := mask
            if !hasDup {
                if mask&(1<<d) != 0 {
                    newHasDup = true
                } else {
                    newMask = mask | (1 << d)
                }
            }
            res += dfs(pos+1, newMask, newTight, newHasDup)
        }
        if !tight && !hasDup {
            memo[pos][mask] = res
        }
        return res
    }

    return dfs(0, 0, true, false)
}