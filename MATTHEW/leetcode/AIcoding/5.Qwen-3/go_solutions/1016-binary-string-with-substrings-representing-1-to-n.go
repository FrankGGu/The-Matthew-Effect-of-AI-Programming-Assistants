package main

func canGetAllSubstrings(s string, n int) bool {
    maxLen := len(s)
    for i := 1; i <= n; i++ {
        bin := strconv.FormatInt(int64(i), 2)
        if !strings.Contains(s, bin) {
            return false
        }
    }
    return true
}

func isPossible(s string, n int) bool {
    if len(s) < 1 {
        return false
    }
    for i := 1; i <= n; i++ {
        bin := strconv.FormatInt(int64(i), 2)
        if !strings.Contains(s, bin) {
            return false
        }
    }
    return true
}

func queryString(s string, n int) bool {
    if n == 0 {
        return true
    }
    if len(s) < 1 {
        return false
    }
    for i := 1; i <= n; i++ {
        bin := strconv.FormatInt(int64(i), 2)
        if !strings.Contains(s, bin) {
            return false
        }
    }
    return true
}