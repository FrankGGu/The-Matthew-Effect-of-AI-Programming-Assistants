package main

func minLengthAfterOperations(s string) int {
    stack := []rune{}
    for _, c := range s {
        if len(stack) > 0 && ((stack[len(stack)-1] == 'a' && c == 'b') || (stack[len(stack)-1] == 'b' && c == 'a')) {
            stack = stack[:len(stack)-1]
        } else {
            stack = append(stack, c)
        }
    }
    return len(stack)
}