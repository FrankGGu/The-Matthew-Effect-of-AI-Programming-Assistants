package main

func compressString(s string) string {
    var result []rune
    n := len(s)
    for i := 0; i < n; {
        char := s[i]
        count := 0
        for j := i; j < n && s[j] == char; j++ {
            count++
        }
        result = append(result, rune(char), rune('0'+count))
        i += count
    }
    return string(result)
}