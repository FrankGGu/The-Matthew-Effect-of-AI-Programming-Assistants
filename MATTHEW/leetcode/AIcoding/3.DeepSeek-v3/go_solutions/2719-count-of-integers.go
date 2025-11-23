func count(num1 string, num2 string, min_sum int, max_sum int) int {
    const mod = 1e9 + 7
    var memo [][][]int
    var s string

    var dfs func(pos int, sum int, limit bool) int
    dfs = func(pos int, sum int, limit bool) int {
        if pos == len(s) {
            if sum >= min_sum && sum <= max_sum {
                return 1
            }
            return 0
        }
        if memo[pos][sum][boolToInt(limit)] != -1 {
            return memo[pos][sum][boolToInt(limit)]
        }
        res := 0
        up := 9
        if limit {
            up = int(s[pos] - '0')
        }
        for d := 0; d <= up; d++ {
            newLimit := limit && (d == up)
            newSum := sum + d
            if newSum > max_sum {
                continue
            }
            res = (res + dfs(pos+1, newSum, newLimit)) % mod
        }
        memo[pos][sum][boolToInt(limit)] = res
        return res
    }

    calc := func(num string) int {
        s = num
        memo = make([][][]int, len(s))
        for i := range memo {
            memo[i] = make([][]int, max_sum+1)
            for j := range memo[i] {
                memo[i][j] = make([]int, 2)
                memo[i][j][0] = -1
                memo[i][j][1] = -1
            }
        }
        return dfs(0, 0, true)
    }

    res := (calc(num2) - calc(num1) + mod) % mod
    sum := 0
    for _, c := range num1 {
        sum += int(c - '0')
    }
    if sum >= min_sum && sum <= max_sum {
        res = (res + 1) % mod
    }
    return res
}

func boolToInt(b bool) int {
    if b {
        return 1
    }
    return 0
}