package main

func isAdditiveNumber(num string) bool {
    n := len(num)
    for i := 1; i < n-1; i++ {
        if num[0] == '0' && i > 1 {
            break
        }
        a := parseNum(num, 0, i)
        for j := i + 1; j < n; j++ {
            if num[i] == '0' && j > i+1 {
                break
            }
            b := parseNum(num, i, j)
            if dfs(num, j, a, b) {
                return true
            }
        }
    }
    return false
}

func parseNum(num string, start, end int) int {
    val := 0
    for i := start; i < end; i++ {
        val = val*10 + int(num[i]-'0')
    }
    return val
}

func dfs(num string, start int, a, b int) bool {
    if start == len(num) {
        return true
    }
    for end := start + 1; end <= len(num); end++ {
        if num[start] == '0' && end > start+1 {
            break
        }
        c := parseNum(num, start, end)
        if c == a + b {
            if dfs(num, end, b, c) {
                return true
            }
        } else if c > a + b {
            break
        }
    }
    return false
}