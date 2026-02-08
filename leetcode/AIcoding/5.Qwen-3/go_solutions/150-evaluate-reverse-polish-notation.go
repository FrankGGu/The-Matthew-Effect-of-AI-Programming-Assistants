package main

func evalRPN(tokens []string) int {
    stack := []int{}
    for _, token := range tokens {
        switch token {
        case "+":
            a, b := stack[len(stack)-2], stack[len(stack)-1]
            stack = stack[:len(stack)-2]
            stack = append(stack, a+b)
        case "-":
            a, b := stack[len(stack)-2], stack[len(stack)-1]
            stack = stack[:len(stack)-2]
            stack = append(stack, a-b)
        case "*":
            a, b := stack[len(stack)-2], stack[len(stack)-1]
            stack = stack[:len(stack)-2]
            stack = append(stack, a*b)
        case "/":
            a, b := stack[len(stack)-2], stack[len(stack)-1]
            stack = stack[:len(stack)-2]
            stack = append(stack, a/b)
        default:
            num := 0
            for _, ch := range token {
                if ch >= '0' && ch <= '9' {
                    num = num*10 + int(ch-'0')
                }
            }
            stack = append(stack, num)
        }
    }
    return stack[0]
}