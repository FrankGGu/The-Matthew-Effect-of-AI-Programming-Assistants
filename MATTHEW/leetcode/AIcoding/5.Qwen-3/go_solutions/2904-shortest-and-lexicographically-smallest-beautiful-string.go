package main

func shortestBeautifulString(n int, k int, targetWord string) string {
    var res string
    var dfs func(string, int)
    dfs = func(s string, idx int) {
        if len(s) == n {
            if isBeautiful(s) {
                if res == "" || len(s) < len(res) || (len(s) == len(res) && s < res) {
                    res = s
                }
            }
            return
        }
        for c := 'a'; c <= 'z'; c++ {
            if idx > 0 && s[idx-1] == byte(c) {
                continue
            }
            next := s + string(c)
            dfs(next, idx+1)
        }
    }
    dfs("", 0)
    return res
}

func isBeautiful(s string) bool {
    count := make(map[byte]int)
    for i := 0; i < len(s); i++ {
        count[s[i]]++
        if count[s[i]] >= 2 {
            return false
        }
    }
    return true
}