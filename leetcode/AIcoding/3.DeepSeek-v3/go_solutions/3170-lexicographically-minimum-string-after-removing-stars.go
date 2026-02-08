func minRemoveToMakeValid(s string) string {
    stack := make([]int, 0)
    remove := make(map[int]bool)
    for i, ch := range s {
        if ch == '(' {
            stack = append(stack, i)
        } else if ch == ')' {
            if len(stack) > 0 {
                stack = stack[:len(stack)-1]
            } else {
                remove[i] = true
            }
        }
    }
    for _, i := range stack {
        remove[i] = true
    }
    var res strings.Builder
    for i, ch := range s {
        if !remove[i] {
            res.WriteRune(ch)
        }
    }
    return res.String()
}