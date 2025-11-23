package main

func longestNiceSubstring(s string) string {
    var result string
    for i := 0; i < len(s); i++ {
        for j := i + 1; j <= len(s); j++ {
            substr := s[i:j]
            if isNice(substr) && len(substr) > len(result) {
                result = substr
            }
        }
    }
    return result
}

func isNice(s string) bool {
    for _, c := range s {
        if !contains(s, byte(c)) || !contains(s, byte(c^32)) {
            return false
        }
    }
    return true
}

func contains(s string, c byte) bool {
    for i := 0; i < len(s); i++ {
        if s[i] == c {
            return true
        }
    }
    return false
}