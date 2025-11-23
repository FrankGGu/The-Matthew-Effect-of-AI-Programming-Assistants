func maximumGain(s string, x int, y int) int {
    a, b := "a", "b"
    if x < y {
        a, b = "b", "a"
        x, y = y, x
    }
    res := 0
    stack := make([]byte, 0)
    for i := 0; i < len(s); i++ {
        c := s[i]
        if len(stack) > 0 && stack[len(stack)-1] == a[0] && c == b[0] {
            stack = stack[:len(stack)-1]
            res += x
        } else {
            stack = append(stack, c)
        }
    }
    s2 := make([]byte, len(stack))
    for i := 0; i < len(stack); i++ {
        s2[i] = stack[i]
    }
    stack = make([]byte, 0)
    for i := 0; i < len(s2); i++ {
        c := s2[i]
        if len(stack) > 0 && stack[len(stack)-1] == b[0] && c == a[0] {
            stack = stack[:len(stack)-1]
            res += y
        } else {
            stack = append(stack, c)
        }
    }
    return res
}