func calculate(s string) int {
    stack := []int{}
    num := 0
    sign := '+'
    for i, ch := range s {
        if ch >= '0' && ch <= '9' {
            num = num*10 + int(ch-'0')
        }
        if (ch != ' ' && (ch < '0' || ch > '9')) || i == len(s)-1 {
            switch sign {
            case '+':
                stack = append(stack, num)
            case '-':
                stack = append(stack, -num)
            case '*':
                stack[len(stack)-1] *= num
            case '/':
                stack[len(stack)-1] /= num
            }
            sign = ch
            num = 0
        }
    }
    res := 0
    for _, v := range stack {
        res += v
    }
    return res
}