package main

func isSubstringPresent(s string) bool {
    reversed := reverse(s)
    for i := 0; i < len(s); i++ {
        for j := i + 1; j <= len(s); j++ {
            if contains(reversed, s[i:j]) {
                return true
            }
        }
    }
    return false
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}

func contains(s string, substr string) bool {
    for i := 0; i <= len(s)-len(substr); i++ {
        match := true
        for j := 0; j < len(substr); j++ {
            if s[i+j] != substr[j] {
                match = false
                break
            }
        }
        if match {
            return true
        }
    }
    return false
}