func smallestSubsequence(s string) string {
    last := make([]int, 26)
    for i, ch := range s {
        last[ch-'a'] = i
    }

    stack := []byte{}
    seen := [26]bool{}

    for i, ch := range s {
        if seen[ch-'a'] {
            continue
        }

        for len(stack) > 0 && stack[len(stack)-1] > byte(ch) && last[stack[len(stack)-1]-'a'] > i {
            seen[stack[len(stack)-1]-'a'] = false
            stack = stack[:len(stack)-1]
        }

        stack = append(stack, byte(ch))
        seen[ch-'a'] = true
    }

    return string(stack)
}