package main

func minStickers(s, target string) int {
    from := make(map[rune]int)
    for _, c := range s {
        from[c]++
    }
    to := make(map[rune]int)
    for _, c := range target {
        to[c]++
    }
    var dfs func(map[rune]int) int
    memo := make(map[string]int)
    dfs = func(m map[rune]int) int {
        key := ""
        for c := range m {
            key += string(c) + strconv.Itoa(m[c])
        }
        if val, ok := memo[key]; ok {
            return val
        }
        if len(m) == 0 {
            return 0
        }
        res := math.MaxInt32
        for c := range m {
            if from[c] == 0 {
                continue
            }
            next := make(map[rune]int)
            for k, v := range m {
                next[k] = v
            }
            next[c]--
            if next[c] == 0 {
                delete(next, c)
            }
            temp := dfs(next)
            if temp != math.MaxInt32 {
                res = min(res, 1+temp)
            }
        }
        memo[key] = res
        return res
    }
    return dfs(to)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}