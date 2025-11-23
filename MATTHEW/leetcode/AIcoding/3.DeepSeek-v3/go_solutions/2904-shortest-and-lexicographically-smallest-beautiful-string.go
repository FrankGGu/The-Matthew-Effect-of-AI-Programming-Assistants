func shortestBeautifulSubstring(s string, k int) string {
    n := len(s)
    minLen := n + 1
    res := ""
    for i := 0; i < n; i++ {
        count := 0
        for j := i; j < n; j++ {
            if s[j] == '1' {
                count++
            }
            if count == k {
                substr := s[i : j+1]
                if len(substr) < minLen {
                    minLen = len(substr)
                    res = substr
                } else if len(substr) == minLen && substr < res {
                    res = substr
                }
                break
            }
        }
    }
    if minLen == n+1 {
        return ""
    }
    return res
}