package main

func countSubstrings(s string, k int) int {
    n := len(s)
    count := 0
    for i := 0; i < n; i++ {
        freq := make(map[byte]int)
        for j := i; j < n; j++ {
            freq[s[j]]++
            if len(freq) <= k {
                count++
            } else {
                break
            }
        }
    }
    return count
}