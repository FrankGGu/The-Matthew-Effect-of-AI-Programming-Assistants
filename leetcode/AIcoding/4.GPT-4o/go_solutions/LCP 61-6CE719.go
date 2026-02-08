func dailyTemperatures(T []int) []int {
    n := len(T)
    res := make([]int, n)
    stack := []int{}

    for i := 0; i < n; i++ {
        for len(stack) > 0 && T[i] > T[stack[len(stack)-1]] {
            j := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            res[j] = i - j
        }
        stack = append(stack, i)
    }

    return res
}