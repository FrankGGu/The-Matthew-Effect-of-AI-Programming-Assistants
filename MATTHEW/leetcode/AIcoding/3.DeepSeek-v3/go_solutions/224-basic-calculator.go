func calculate(s string) int {
    stack := make([]int, 0)
    num := 0
    sign := 1
    res := 0

    for i := 0; i < len(s); i++ {
        c := s[i]
        if c >= '0' && c <= '9' {
            num = num*10 + int(c-'0')
        } else if c == '+' {
            res += sign * num
            num = 0
            sign = 1
        } else if c == '-' {
            res += sign * num
            num = 0
            sign = -1
        } else if c == '(' {
            stack = append(stack, res)
            stack = append(stack, sign)
            res = 0
            sign = 1
        } else if c == ')' {
            res += sign * num
            num = 0
            res *= stack[len(stack)-1]
            res += stack[len(stack)-2]
            stack = stack[:len(stack)-2]
        }
    }
    if num != 0 {
        res += sign * num
    }
    return res
}