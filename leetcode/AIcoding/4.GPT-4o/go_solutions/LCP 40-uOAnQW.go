func calculate(num1 int, num2 int, op string) int {
    switch op {
    case "+":
        return num1 + num2
    case "-":
        return num1 - num2
    case "*":
        return num1 * num2
    case "/":
        if num2 != 0 {
            return num1 / num2
        }
    }
    return 0
}