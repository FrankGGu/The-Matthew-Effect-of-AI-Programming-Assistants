func hasAllCodes(s string, k int) bool {
    need := 1 << k
    seen := make(map[string]bool)

    for i := 0; i <= len(s)-k; i++ {
        substr := s[i:i+k]
        if !seen[substr] {
            seen[substr] = true
            need--
            if need == 0 {
                return true
            }
        }
    }
    return false
}