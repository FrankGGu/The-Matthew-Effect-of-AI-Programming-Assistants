package main

func distinctEchoSubstrings(s string) int {
    n := len(s)
    seen := make(map[string]bool)
    result := 0

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if (j-i) > (n-j) {
                continue
            }
            if s[i:j] == s[j:2*j-i] {
                seen[s[i:j]] = true
            }
        }
    }

    for range seen {
        result++
    }

    return result
}