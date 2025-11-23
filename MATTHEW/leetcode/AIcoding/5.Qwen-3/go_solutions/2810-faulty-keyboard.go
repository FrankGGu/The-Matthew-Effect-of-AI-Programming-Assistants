package main

func finalString(s string) string {
    result := make([]byte, 0, len(s))
    for i := 0; i < len(s); i++ {
        if s[i] == '#' {
            if len(result) > 0 {
                result = result[:len(result)-1]
            }
        } else {
            result = append(result, s[i])
        }
    }
    return string(result)
}