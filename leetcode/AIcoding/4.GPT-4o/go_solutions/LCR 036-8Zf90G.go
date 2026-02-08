func evalRPN(tokens []string) int {
    stack := []int{}
    for _, token := range tokens {
        switch token {
        case "+":
            a := stack[len(stack)-2]
            b := stack[len(stack)-1]
            stack = stack[:len(stack)-2]
            stack = append(stack, a+b)
        case "-":
            a := stack[len(stack)-2]
            b := stack[len(stack)-1]
            stack = stack[:len(stack)-2]
            stack = append(stack, a-b)
        case "*":
            a := stack[len(stack)-2]
            b := stack[len(stack)-1]
            stack = stack[:len(stack)-2]
            stack = append(stack, a*b)
        case "/":
            a := stack[len(stack)-2]
            b := stack[len(stack)-1]
            stack = stack[:len(stack)-2]
            stack = append(stack, a/b)
        default:
            num, _ := strconv.Atoi(token)
            stack = append(stack, num)
        }
    }
    return stack[0]
}