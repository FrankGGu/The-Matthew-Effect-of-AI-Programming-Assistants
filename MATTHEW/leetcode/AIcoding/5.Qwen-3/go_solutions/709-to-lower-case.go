package main

func toLowerCase(s string) string {
    result := []rune(s)
    for i := range result {
        if result[i] >= 'A' && result[i] <= 'Z' {
            result[i] += 32
        }
    }
    return string(result)
}