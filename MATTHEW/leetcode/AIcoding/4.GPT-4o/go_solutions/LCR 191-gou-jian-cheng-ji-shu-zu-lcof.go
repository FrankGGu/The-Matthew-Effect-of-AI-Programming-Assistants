func calPoints(ops []string) int {
    var stack []int
    for _, op := range ops {
        switch op {
        case "+":
            n := len(stack)
            stack = append(stack, stack[n-1]+stack[n-2])
        case "D":
            stack = append(stack, 2*stack[len(stack)-1])
        case "C":
            stack = stack[:len(stack)-1]
        default:
            var points int
            fmt.Sscanf(op, "%d", &points)
            stack = append(stack, points)
        }
    }

    total := 0
    for _, score := range stack {
        total += score
    }
    return total
}