func numberOfBeautifulIntegers(low int, high int, k int) int {
    lowStr := strconv.Itoa(low - 1)
    highStr := strconv.Itoa(high)
    return countBeautiful(highStr, k) - countBeautiful(lowStr, k)
}

func countBeautiful(s string, k int) int {
    n := len(s)
    memo := make([][][]int, n)
    for i := range memo {
        memo[i] = make([][]int, 21)
        for j := range memo[i] {
            memo[i][j] = make([]int, 21)
            for k := range memo[i][j] {
                memo[i][j][k] = -1
            }
        }
    }

    var dfs func(pos, mod, diff int, tight bool) int
    dfs = func(pos, mod, diff int, tight bool) int {
        if pos == n {
            if mod == 0 && diff == 10 {
                return 1
            }
            return 0
        }
        if !tight {
            if memo[pos][mod][diff] != -1 {
                return memo[pos][mod][diff]
            }
        }
        limit := 9
        if tight {
            limit = int(s[pos] - '0')
        }
        res := 0
        for d := 0; d <= limit; d++ {
            newTight := tight && (d == limit)
            newMod := (mod * 10 + d) % k
            newDiff := diff
            if d % 2 == 0 {
                newDiff++
            } else {
                newDiff--
            }
            res += dfs(pos + 1, newMod, newDiff, newTight)
        }
        if !tight {
            memo[pos][mod][diff] = res
        }
        return res
    }
    return dfs(0, 0, 10, true)
}