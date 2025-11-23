func removeKdigits(num string, k int) string {
    stack := []byte{}
    for i := range num {
        for k > 0 && len(stack) > 0 && stack[len(stack)-1] > num[i] {
            stack = stack[:len(stack)-1]
            k--
        }
        stack = append(stack, num[i])
    }
    stack = stack[:len(stack)-k]
    res := strings.TrimLeft(string(stack), "0")
    if res == "" {
        return "0"
    }
    return res
}