func busRapidTransit(target int, inc int, dec int, jump []int, cost []int) int {
    memo := make(map[int]int)
    var dfs func(int) int
    dfs = func(pos int) int {
        if pos == 0 {
            return 0
        }
        if val, ok := memo[pos]; ok {
            return val
        }
        res := pos * inc
        for i := 0; i < len(jump); i++ {
            j := jump[i]
            c := cost[i]
            q, r := pos/j, pos%j
            if r == 0 {
                res = min(res, dfs(q)+c)
            } else {
                res = min(res, dfs(q)+c+r*inc)
                res = min(res, dfs(q+1)+c+(j-r)*dec)
            }
        }
        memo[pos] = res
        return res
    }
    return dfs(target) % 1000000007
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}