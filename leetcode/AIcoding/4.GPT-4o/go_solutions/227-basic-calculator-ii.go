func calculate(s string) int {
    stack := []int{}
    num := 0
    operation := byte('+')

    for i := 0; i < len(s); i++ {
        if s[i] >= '0' && s[i] <= '9' {
            num = num*10 + int(s[i]-'0')
        }
        if (s[i] < '0' || s[i] > '9') && s[i] != ' ' || i == len(s)-1 {
            switch operation {
            case '+':
                stack = append(stack, num)
            case '-':
                stack = append(stack, -num)
            case '*':
                stack[len(stack)-1] *= num
            case '/':
                stack[len(stack)-1] /= num
            }
            operation = s[i]
            num = 0
        }
    }

    result := 0
    for _, v := range stack {
        result += v
    }

    return result
}