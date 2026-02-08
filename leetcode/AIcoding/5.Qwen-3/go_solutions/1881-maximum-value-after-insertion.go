package main

func maximumValue(s string) int {
    maxVal := 0
    for i := 0; i < len(s); i++ {
        if s[i] >= 'a' && s[i] <= 'z' {
            maxVal = max(maxVal, int(s[i]-'a'+1))
        }
    }
    return maxVal
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}