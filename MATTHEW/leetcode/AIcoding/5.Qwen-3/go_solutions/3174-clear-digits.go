package main

func clearDigits(s string) string {
    stack := []rune{}
    for _, c := range s {
        if c >= '0' && c <= '9' {
            if len(stack) > 0 {
                stack = stack[:len(stack)-1]
            }
        } else {
            stack = append(stack, c)
        }
    }
    return string(stack)
}