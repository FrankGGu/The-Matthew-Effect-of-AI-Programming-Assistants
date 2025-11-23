package main

func sumScores(s string) int {
    n := len(s)
    lps := make([]int, n)
    for i := 1; i < n; i++ {
        j := lps[i-1]
        for j > 0 && s[i] != s[j] {
            j = lps[j-1]
        }
        if s[i] == s[j] {
            j++
        }
        lps[i] = j
    }
    total := 0
    for _, v := range lps {
        total += v
    }
    return total
}