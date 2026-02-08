func smallestNumber(pattern string) string {
    n := len(pattern)
    res := make([]byte, n+1)
    stack := []int{}
    num := byte('1')

    for i := 0; i <= n; i++ {
        stack = append(stack, i)
        if i == n || pattern[i] == 'I' {
            for len(stack) > 0 {
                pos := stack[len(stack)-1]
                stack = stack[:len(stack)-1]
                res[pos] = num
                num++
            }
        }
    }

    return string(res)
}