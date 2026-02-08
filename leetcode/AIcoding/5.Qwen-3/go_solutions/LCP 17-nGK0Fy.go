package main

func calculate(s string) int {
    var stack []int
    num := 0
    sign := '+'
    for i := 0; i < len(s); i++ {
        c := s[i]
        if c >= '0' && c <= '9' {
            num = num*10 + int(c-'0')
        }
        if (c < '0' && c != ' ') || i == len(s)-1 {
            switch sign {
            case '+':
                stack = append(stack, num)
            case '-':
                stack = append(stack, -num)
            case '*':
                stack[len(stack)-1] = stack[len(stack)-1] * num
            case '/':
                stack[len(stack)-1] = stack[len(stack)-1] / num
            }
            sign = c
            num = 0
        }
    }
    res := 0
    for _, v := range stack {
        res += v
    }
    return res
}