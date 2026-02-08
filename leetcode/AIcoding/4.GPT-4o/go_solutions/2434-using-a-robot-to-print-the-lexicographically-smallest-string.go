func robotWithString(s string) string {
    n := len(s)
    result := make([]byte, 0)
    stack := make([]byte, 0)
    count := make([]int, 26)

    for i := 0; i < n; i++ {
        count[s[i]-'a']++
    }

    for i := 0; i < n; i++ {
        stack = append(stack, s[i])
        count[s[i]-'a']--

        for len(stack) > 0 && (len(stack) == 1 || stack[len(stack)-1] <= minRemaining(count)) {
            result = append(result, stack[len(stack)-1])
            stack = stack[:len(stack)-1]
        }
    }

    return string(result)
}

func minRemaining(count []int) byte {
    for i := 0; i < 26; i++ {
        if count[i] > 0 {
            return byte(i + 'a')
        }
    }
    return 0
}