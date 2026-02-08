package main

func countBeautifulSubstrings(s string, k int) int {
    count := 0
    n := len(s)
    for i := 0; i < n; i++ {
        vowels := 0
        for j := i; j < n; j++ {
            if s[j] == 'a' || s[j] == 'e' || s[j] == 'i' || s[j] == 'o' || s[j] == 'u' {
                vowels++
            }
            if (j-i+1)%k == 0 && vowels == (j-i+1)/k {
                count++
            }
        }
    }
    return count
}