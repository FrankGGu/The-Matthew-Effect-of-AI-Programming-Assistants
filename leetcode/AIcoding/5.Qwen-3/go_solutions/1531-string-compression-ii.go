package main

func getLengthOfOptimalCompression(s string, k int) int {
    memo := make(map[string]int)
    var dp func(int, int, byte, int) int
    dp = func(i, deletions int, prev byte, count int) int {
        if i == len(s) {
            return 0
        }
        key := fmt.Sprintf("%d,%d,%c,%d", i, deletions, prev, count)
        if val, found := memo[key]; found {
            return val
        }
        res := 0
        if deletions > 0 {
            res = dp(i+1, deletions-1, prev, count)
        }
        if s[i] == prev {
            add := 0
            if count == 1 || count == 9 || count == 99 {
                add = 1
            }
            res = max(res, add+dp(i+1, deletions, prev, count+1))
        } else {
            res = max(res, dp(i+1, deletions, s[i], 1))
        }
        memo[key] = res
        return res
    }
    return dp(0, k, 0, 0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}