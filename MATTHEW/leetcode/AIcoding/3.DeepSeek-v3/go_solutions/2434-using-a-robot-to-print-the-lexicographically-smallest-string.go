func robotWithString(s string) string {
    n := len(s)
    minRight := make([]byte, n)
    minRight[n-1] = s[n-1]
    for i := n - 2; i >= 0; i-- {
        if s[i] < minRight[i+1] {
            minRight[i] = s[i]
        } else {
            minRight[i] = minRight[i+1]
        }
    }

    stack := make([]byte, 0)
    var res strings.Builder

    for i := 0; i < n; i++ {
        stack = append(stack, s[i])
        for len(stack) > 0 && (i == n-1 || stack[len(stack)-1] <= minRight[i+1]) {
            res.WriteByte(stack[len(stack)-1])
            stack = stack[:len(stack)-1]
        }
    }

    return res.String()
}