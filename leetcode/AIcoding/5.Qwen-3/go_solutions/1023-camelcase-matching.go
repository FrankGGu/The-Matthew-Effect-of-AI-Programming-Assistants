package main

func camelMatch(queries []string, pattern string) []bool {
    result := make([]bool, len(queries))
    for i, q := range queries {
        result[i] = match(q, pattern)
    }
    return result
}

func match(s, p string) bool {
    i, j := 0, 0
    for i < len(s) {
        if j < len(p) && s[i] == p[j] {
            i++
            j++
        } else if s[i] >= 'A' && s[i] <= 'Z' {
            return false
        } else {
            i++
        }
    }
    return j == len(p)
}