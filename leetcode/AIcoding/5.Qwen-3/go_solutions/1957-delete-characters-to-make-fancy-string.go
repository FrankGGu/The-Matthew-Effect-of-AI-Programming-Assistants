package main

func makeFancyString(s string) string {
    if len(s) < 2 {
        return s
    }
    result := []rune{s[0]}
    for i := 1; i < len(s); i++ {
        if s[i] == result[len(result)-1] && len(result) > 0 && s[i] == result[len(result)-1] {
            continue
        }
        result = append(result, s[i])
    }
    return string(result)
}