func backspaceCompare(s string, t string) bool {
    return build(s) == build(t)
}

func build(str string) string {
    stack := []byte{}
    for i := 0; i < len(str); i++ {
        if str[i] != '#' {
            stack = append(stack, str[i])
        } else {
            if len(stack) > 0 {
                stack = stack[:len(stack)-1]
            }
        }
    }
    return string(stack)
}