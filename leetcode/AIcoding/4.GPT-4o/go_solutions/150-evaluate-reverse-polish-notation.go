func evalRPN(tokens []string) int {
    stack := []int{}
    for _, token := range tokens {
        switch token {
        case "+":
            n := len(stack) - 1
            stack[n-1] = stack[n-1] + stack[n]
            stack = stack[:n]
        case "-":
            n := len(stack) - 1
            stack[n-1] = stack[n-1] - stack[n]
            stack = stack[:n]
        case "*":
            n := len(stack) - 1
            stack[n-1] = stack[n-1] * stack[n]
            stack = stack[:n]
        case "/":
            n := len(stack) - 1
            stack[n-1] = stack[n-1] / stack[n]
            stack = stack[:n]
        default:
            num, _ := strconv.Atoi(token)
            stack = append(stack, num)
        }
    }
    return stack[0]
}