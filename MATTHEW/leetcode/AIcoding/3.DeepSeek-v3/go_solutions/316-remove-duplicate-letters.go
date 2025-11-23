func removeDuplicateLetters(s string) string {
    count := make([]int, 26)
    visited := make([]bool, 26)
    stack := make([]byte, 0)

    for i := 0; i < len(s); i++ {
        count[s[i]-'a']++
    }

    for i := 0; i < len(s); i++ {
        ch := s[i]
        count[ch-'a']--
        if visited[ch-'a'] {
            continue
        }
        for len(stack) > 0 && ch < stack[len(stack)-1] && count[stack[len(stack)-1]-'a'] > 0 {
            visited[stack[len(stack)-1]-'a'] = false
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, ch)
        visited[ch-'a'] = true
    }

    return string(stack)
}