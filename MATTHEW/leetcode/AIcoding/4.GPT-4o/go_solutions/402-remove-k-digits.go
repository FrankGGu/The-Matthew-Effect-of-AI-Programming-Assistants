func removeKdigits(num string, k int) string {
    if k >= len(num) {
        return "0"
    }

    stack := []byte{}
    for i := 0; i < len(num); i++ {
        for len(stack) > 0 && k > 0 && stack[len(stack)-1] > num[i] {
            stack = stack[:len(stack)-1]
            k--
        }
        stack = append(stack, num[i])
    }

    stack = stack[:len(stack)-k]

    result := string(stack)
    result = strings.TrimLeft(result, "0")

    if result == "" {
        return "0"
    }
    return result
}