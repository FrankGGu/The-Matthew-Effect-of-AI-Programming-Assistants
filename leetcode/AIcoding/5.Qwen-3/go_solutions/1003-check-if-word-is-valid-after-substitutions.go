package main

func isValid(s string) bool {
    stack := []rune{}
    for _, char := range s {
        if char == 'a' || char == 'b' || char == 'c' {
            if len(stack) > 0 && stack[len(stack)-1] == 'a' && char == 'b' {
                stack = stack[:len(stack)-1]
            } else if len(stack) > 0 && stack[len(stack)-1] == 'b' && char == 'c' {
                stack = stack[:len(stack)-1]
            } else {
                stack = append(stack, char)
            }
        } else {
            return false
        }
    }
    return len(stack) == 0
}