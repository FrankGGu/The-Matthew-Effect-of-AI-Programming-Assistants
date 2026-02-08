func evalRPN(tokens []string) int {
    stack := make([]int, 0)
    for _, token := range tokens {
        if num, err := strconv.Atoi(token); err == nil {
            stack = append(stack, num)
        } else {
            a, b := stack[len(stack)-2], stack[len(stack)-1]
            stack = stack[:len(stack)-2]
            var res int
            switch token {
            case "+":
                res = a + b
            case "-":
                res = a - b
            case "*":
                res = a * b
            case "/":
                res = a / b
            }
            stack = append(stack, res)
        }
    }
    return stack[0]
}