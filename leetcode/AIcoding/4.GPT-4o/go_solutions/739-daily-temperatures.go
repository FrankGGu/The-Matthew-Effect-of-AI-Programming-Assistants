func dailyTemperatures(T []int) []int {
    n := len(T)
    result := make([]int, n)
    stack := []int{}

    for i := 0; i < n; i++ {
        for len(stack) > 0 && T[i] > T[stack[len(stack)-1]] {
            idx := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            result[idx] = i - idx
        }
        stack = append(stack, i)
    }

    return result
}