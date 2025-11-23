func removeDuplicates(S string) string {
    stack := []rune{}
    for _, ch := range S {
        if len(stack) > 0 && stack[len(stack)-1] == ch {
            stack = stack[:len(stack)-1]
        } else {
            stack = append(stack, ch)
        }
    }
    return string(stack)
}