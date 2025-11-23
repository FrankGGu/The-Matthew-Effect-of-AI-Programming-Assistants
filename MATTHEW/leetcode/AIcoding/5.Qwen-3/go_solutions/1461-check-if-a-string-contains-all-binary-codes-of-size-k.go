package main

func hasAllCodesToMakeString(s string, k int) bool {
    seen := make(map[string]bool)
    n := len(s)
    for i := 0; i <= n - k; i++ {
        substr := s[i:i+k]
        seen[substr] = true
    }
    return len(seen) == (1 << k)
}