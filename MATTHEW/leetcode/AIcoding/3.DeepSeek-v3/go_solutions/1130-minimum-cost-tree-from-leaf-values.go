func mctFromLeafValues(arr []int) int {
    res := 0
    stack := []int{math.MaxInt32}

    for _, num := range arr {
        for stack[len(stack)-1] <= num {
            mid := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            res += mid * min(stack[len(stack)-1], num)
        }
        stack = append(stack, num)
    }

    for len(stack) > 2 {
        res += stack[len(stack)-1] * stack[len(stack)-2]
        stack = stack[:len(stack)-1]
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}