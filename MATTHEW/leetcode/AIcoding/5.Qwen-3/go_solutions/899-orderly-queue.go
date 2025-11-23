package main

func orderlyQueue(s string, k int) string {
    if k == 0 {
        return s
    }
    if k > 1 {
        runes := []rune(s)
        for i := 0; i < len(runes)-1; i++ {
            for j := i + 1; j < len(runes); j++ {
                if runes[i] > runes[j] {
                    runes[i], runes[j] = runes[j], runes[i]
                }
            }
        }
        return string(runes)
    }
    minStr := s
    for i := 0; i < len(s); i++ {
        rotated := s[i:] + s[:i]
        if rotated < minStr {
            minStr = rotated
        }
    }
    return minStr
}