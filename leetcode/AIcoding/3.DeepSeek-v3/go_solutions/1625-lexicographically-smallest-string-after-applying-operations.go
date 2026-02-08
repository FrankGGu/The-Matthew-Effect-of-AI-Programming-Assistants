func findLexSmallestString(s string, a int, b int) string {
    n := len(s)
    visited := make(map[string]bool)
    queue := []string{s}
    visited[s] = true
    res := s

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]

        if current < res {
            res = current
        }

        addOp := []byte(current)
        for i := 1; i < n; i += 2 {
            addOp[i] = byte((int(addOp[i]-'0')+a)%10 + '0')
        }
        newStr := string(addOp)
        if !visited[newStr] {
            visited[newStr] = true
            queue = append(queue, newStr)
        }

        rotateStr := current[n-b:] + current[:n-b]
        if !visited[rotateStr] {
            visited[rotateStr] = true
            queue = append(queue, rotateStr)
        }
    }
    return res
}