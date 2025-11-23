func smallestString(s string) string {
    stack := []byte{}
    for i := 0; i < len(s); i++ {
        c := s[i]
        for len(stack) > 0 && stack[len(stack)-1] > c {
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, c)
    }
    return string(stack)
}