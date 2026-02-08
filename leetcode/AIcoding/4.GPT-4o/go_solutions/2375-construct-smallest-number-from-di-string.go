func smallestNumber(pattern string) string {
    n := len(pattern)
    result := make([]byte, n+1)
    stack := []int{}

    for i := 0; i <= n; i++ {
        stack = append(stack, i+1)
        if i == n || pattern[i] == 'I' {
            for len(stack) > 0 {
                result[i-len(stack)+1] = byte(stack[len(stack)-1] + '0')
                stack = stack[:len(stack)-1]
            }
        }
    }
    return string(result)
}