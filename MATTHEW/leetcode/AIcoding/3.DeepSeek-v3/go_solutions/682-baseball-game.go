func calPoints(operations []string) int {
    stack := make([]int, 0)
    for _, op := range operations {
        switch op {
        case "+":
            if len(stack) >= 2 {
                stack = append(stack, stack[len(stack)-1]+stack[len(stack)-2])
            }
        case "D":
            if len(stack) >= 1 {
                stack = append(stack, 2*stack[len(stack)-1])
            }
        case "C":
            if len(stack) >= 1 {
                stack = stack[:len(stack)-1]
            }
        default:
            num, _ := strconv.Atoi(op)
            stack = append(stack, num)
        }
    }
    sum := 0
    for _, num := range stack {
        sum += num
    }
    return sum
}