func smallestNumber(pattern string) string {
    n := len(pattern)
    res := make([]byte, n+1)
    stack := make([]int, 0)
    current := byte('1')
    for i := 0; i <= n; i++ {
        stack = append(stack, i)
        if i == n || pattern[i] == 'I' {
            for len(stack) > 0 {
                idx := stack[len(stack)-1]
                stack = stack[:len(stack)-1]
                res[idx] = current
                current++
            }
        }
    }
    return string(res)
}