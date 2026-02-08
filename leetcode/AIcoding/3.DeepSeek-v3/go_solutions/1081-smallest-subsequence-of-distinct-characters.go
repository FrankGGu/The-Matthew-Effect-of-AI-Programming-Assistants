func smallestSubsequence(s string) string {
    count := make([]int, 26)
    visited := make([]bool, 26)
    stack := make([]byte, 0)

    for _, ch := range s {
        count[ch-'a']++
    }

    for _, ch := range s {
        idx := ch - 'a'
        count[idx]--
        if visited[idx] {
            continue
        }
        for len(stack) > 0 && stack[len(stack)-1] > byte(ch) && count[stack[len(stack)-1]-'a'] > 0 {
            visited[stack[len(stack)-1]-'a'] = false
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, byte(ch))
        visited[idx] = true
    }

    return string(stack)
}