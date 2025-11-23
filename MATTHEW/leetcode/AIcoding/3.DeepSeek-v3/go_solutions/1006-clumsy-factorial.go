func clumsy(N int) int {
    stack := []int{N}
    index := 0
    N--

    for N > 0 {
        switch index % 4 {
        case 0:
            stack[len(stack)-1] *= N
        case 1:
            stack[len(stack)-1] /= N
        case 2:
            stack = append(stack, N)
        case 3:
            stack = append(stack, -N)
        }
        index++
        N--
    }

    res := 0
    for _, num := range stack {
        res += num
    }
    return res
}