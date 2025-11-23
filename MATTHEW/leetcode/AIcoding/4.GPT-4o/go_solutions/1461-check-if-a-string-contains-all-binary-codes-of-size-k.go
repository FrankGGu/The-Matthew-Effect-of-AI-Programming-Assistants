func hasAllCodes(s string, k int) bool {
    n := len(s)
    if n < k {
        return false
    }
    totalCodes := 1 << k
    seen := make(map[string]bool)

    for i := 0; i <= n-k; i++ {
        code := s[i : i+k]
        seen[code] = true
        if len(seen) == totalCodes {
            return true
        }
    }
    return false
}