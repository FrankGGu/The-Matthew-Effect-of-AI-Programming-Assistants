package main

func countVowels(s string) int {
    n := len(s)
    count := 0
    for i := 0; i < n; i++ {
        if s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u' {
            count += (i + 1) * (n - i)
        }
    }
    return count
}