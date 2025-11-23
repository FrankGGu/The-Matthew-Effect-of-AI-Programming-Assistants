func calculate(s string) int {
    stack := []int{}
    currentNumber := 0
    operation := '+'

    for i := 0; i < len(s); i++ {
        if s[i] >= '0' && s[i] <= '9' {
            currentNumber = currentNumber*10 + int(s[i]-'0')
        }
        if s[i] != ' ' && (s[i] < '0' || s[i] > '9') || i == len(s)-1 {
            switch operation {
            case '+':
                stack = append(stack, currentNumber)
            case '-':
                stack = append(stack, -currentNumber)
            case '*':
                stack[len(stack)-1] *= currentNumber
            case '/':
                stack[len(stack)-1] /= currentNumber
            }
            operation = s[i]
            currentNumber = 0
        }
    }

    result := 0
    for _, num := range stack {
        result += num
    }
    return result
}