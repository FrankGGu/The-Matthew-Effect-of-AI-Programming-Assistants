package main

func countPossibleStrings(s string) int {
    count := 0
    n := len(s)
    for i := 1; i <= n; i++ {
        for j := 0; j <= n-i; j++ {
            substr := s[j : j+i]
            freq := make(map[rune]int)
            for _, c := range substr {
                freq[c]++
            }
            hasSub := false
            for _, v := range freq {
                if v >= 2 {
                    hasSub = true
                    break
                }
            }
            if hasSub {
                count++
            }
        }
    }
    return count
}