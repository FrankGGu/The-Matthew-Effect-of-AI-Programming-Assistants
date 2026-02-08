package main

func decodeInteger(s string) int {
    result := 0
    for _, c := range s {
        if c >= '0' && c <= '9' {
            result = result*10 + int(c-'0')
        }
    }
    return result
}