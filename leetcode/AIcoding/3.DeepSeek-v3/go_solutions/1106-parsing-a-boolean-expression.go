func parseBoolExpr(expression string) bool {
    stack := []rune{}
    for _, ch := range expression {
        if ch == ',' {
            continue
        }
        if ch != ')' {
            stack = append(stack, ch)
            continue
        }
        t, f := 0, 0
        for len(stack) > 0 && stack[len(stack)-1] != '(' {
            val := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            if val == 't' {
                t++
            } else {
                f++
            }
        }
        stack = stack[:len(stack)-1]
        op := stack[len(stack)-1]
        stack = stack[:len(stack)-1]
        var res rune
        switch op {
        case '!':
            if f != 0 {
                res = 't'
            } else {
                res = 'f'
            }
        case '&':
            if f == 0 {
                res = 't'
            } else {
                res = 'f'
            }
        case '|':
            if t != 0 {
                res = 't'
            } else {
                res = 'f'
            }
        }
        stack = append(stack, res)
    }
    return stack[len(stack)-1] == 't'
}