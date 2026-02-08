package main

func countSpecialIntegers(n int) int {
    s := strconv.Itoa(n)
    m := len(s)
    dp := make([][2]int, m+1)
    dp[0][0] = 1
    for i := 1; i <= m; i++ {
        dp[i][0] = dp[i-1][0] * 9
        dp[i][1] = dp[i-1][1] * 9
        if i > 1 {
            dp[i][1] += dp[i-1][0]
        }
    }
    used := make(map[int]bool)
    var dfs func(int, bool, bool) int
    dfs = func(pos int, tight bool, lead bool) int {
        if pos == m {
            return 1
        }
        res := 0
        up := int(s[pos] - '0')
        if tight {
            up = int(s[pos] - '0')
        } else {
            up = 9
        }
        for d := 0; d <= up; d++ {
            newTight := tight && (d == up)
            newLead := lead && (d == 0)
            if !newLead {
                if !used[d] {
                    used[d] = true
                    res += dfs(pos+1, newTight, newLead)
                    used[d] = false
                }
            } else {
                res += dfs(pos+1, newTight, newLead)
            }
        }
        return res
    }
    return dp[m][0] + dfs(0, true, true) - 1
}