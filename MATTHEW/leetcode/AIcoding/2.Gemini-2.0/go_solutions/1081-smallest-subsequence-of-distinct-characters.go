func smallestSubsequence(s string) string {
    last := [26]int{}
    for i := 0; i < len(s); i++ {
        last[s[i]-'a'] = i
    }

    seen := [26]bool{}
    stack := []byte{}

    for i := 0; i < len(s); i++ {
        c := s[i]
        if seen[c-'a'] {
            continue
        }

        for len(stack) > 0 && c < stack[len(stack)-1] && i < last[stack[len(stack)-1]-'a'] {
            seen[stack[len(stack)-1]-'a'] = false
            stack = stack[:len(stack)-1]
        }

        stack = append(stack, c)
        seen[c-'a'] = true
    }

    return string(stack)
}