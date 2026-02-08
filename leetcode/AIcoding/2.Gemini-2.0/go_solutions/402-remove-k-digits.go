func removeKdigits(num string, k int) string {
    stack := []byte{}
    for i := 0; i < len(num); i++ {
        for len(stack) > 0 && k > 0 && stack[len(stack)-1] > num[i] {
            stack = stack[:len(stack)-1]
            k--
        }
        stack = append(stack, num[i])
    }

    for k > 0 {
        stack = stack[:len(stack)-1]
        k--
    }

    res := string(stack)
    i := 0
    for i < len(res)-1 && res[i] == '0' {
        i++
    }
    res = res[i:]

    if len(res) == 0 {
        return "0"
    }
    return res
}