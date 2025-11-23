func canIWin(maxChoosableInteger int, desiredTotal int) bool {
    if desiredTotal <= 0 {
        return true
    }
    if maxChoosableInteger*(maxChoosableInteger+1)/2 < desiredTotal {
        return false
    }

    memo := make(map[int]bool)
    used := make([]bool, maxChoosableInteger+1)

    var dfs func(int) bool
    dfs = func(total int) bool {
        if total <= 0 {
            return false
        }
        key := 0
        for i := 1; i <= maxChoosableInteger; i++ {
            key <<= 1
            if used[i] {
                key |= 1
            }
        }
        if val, ok := memo[key]; ok {
            return val
        }

        for i := 1; i <= maxChoosableInteger; i++ {
            if !used[i] {
                used[i] = true
                if !dfs(total - i) {
                    memo[key] = true
                    used[i] = false
                    return true
                }
                used[i] = false
            }
        }
        memo[key] = false
        return false
    }

    return dfs(desiredTotal)
}