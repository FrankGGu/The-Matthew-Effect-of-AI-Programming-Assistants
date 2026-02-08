package main

func calPoints(ops []string) int {
    stack := []int{}
    for _, op := range ops {
        switch op {
        case "C":
            stack = stack[:len(stack)-1]
        case "D":
            stack = append(stack, stack[len(stack)-1]*2)
        case "O":
            stack = append(stack, stack[len(stack)-2]*2)
        default:
            stack = append(stack, atoi(op))
        }
    }
    sum := 0
    for _, s := range stack {
        sum += s
    }
    return sum
}

func atoi(s string) int {
    var result int
    for _, c := range s {
        result = result*10 + int(c-'0')
    }
    return result
}