package main

func removeOuterParentheses(s string) string {
    result := []rune{}
    count := 0
    for _, char := range s {
        if char == '(' {
            count++
        }
        if count > 1 {
            result = append(result, char)
        }
        if char == ')' {
            count--
        }
    }
    return string(result)
}