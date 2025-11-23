func countSteppingNumbers(low string, high string) int {
    const mod = 1e9 + 7
    memo := make(map[string]int)

    var dfs func(pos int, tight bool, prevDigit int, isLeading bool, s string) int
    dfs = func(pos int, tight bool, prevDigit int, isLeading bool, s string) int {
        if pos == len(s) {
            if isLeading {
                return 0
            }
            return 1
        }
        key := fmt.Sprintf("%d:%v:%d:%v", pos, tight, prevDigit, isLeading)
        if val, ok := memo[key]; ok {
            return val
        }

        limit := 9
        if tight {
            limit = int(s[pos] - '0')
        }

        res := 0
        for d := 0; d <= limit; d++ {
            newTight := tight && (d == limit)
            newIsLeading := isLeading && (d == 0)
            if newIsLeading {
                res = (res + dfs(pos+1, newTight, prevDigit, newIsLeading, s)) % mod
            } else {
                if isLeading || abs(d - prevDigit) == 1 {
                    res = (res + dfs(pos+1, newTight, d, newIsLeading, s)) % mod
                }
            }
        }
        memo[key] = res
        return res
    }

    countHigh := dfs(0, true, 0, true, high)
    memo = make(map[string]int)
    countLow := dfs(0, true, 0, true, low)

    numLow := 0
    for i := 0; i < len(low); i++ {
        numLow = numLow * 10 + int(low[i] - '0')
        numLow %= mod
    }

    isStepping := true
    for i := 1; i < len(low); i++ {
        if abs(int(low[i] - '0') - int(low[i-1] - '0')) != 1 {
            isStepping = false
            break
        }
    }

    if isStepping {
        return (countHigh - countLow + 1 + mod) % mod
    }
    return (countHigh - countLow + mod) % mod
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}