package main

func calculate(s string) int {
    var stack []int
    var num int
    var sign byte
    sign = '+'
    for i := 0; i < len(s); i++ {
        c := s[i]
        if c >= '0' {
            num = num*10 + int(c-'0')
        }
        if (c < '0' && c != ' ') || i == len(s)-1 {
            if sign == '+' {
                stack = append(stack, num)
            } else if sign == '-' {
                stack = append(stack, -num)
            } else if sign == '*' {
                stack[len(stack)-1] = stack[len(stack)-1] * num
            } else if sign == '/' {
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